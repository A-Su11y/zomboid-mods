#!/usr/bin/env python3
"""BMAX "where was I" dashboard for zomboid-mods.

Reads public repo state via the GitHub API + raw.githubusercontent.com and
the server-local SELF_MANAGED_MODS directory. Renders one page every 30s and
a JSON mirror at /api/status. LAN-only; no auth.
"""
from __future__ import annotations

import json
import os
import pathlib
import sys
import threading
import time
from datetime import datetime, timezone

import markdown as md
import requests
from flask import Flask, jsonify, render_template


# --- config ------------------------------------------------------------------

def _load_env_file(path: pathlib.Path) -> None:
    if not path.is_file():
        return
    for raw in path.read_text(encoding="utf-8").splitlines():
        line = raw.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        k, v = line.split("=", 1)
        k = k.strip()
        v = v.strip().strip('"').strip("'")
        os.environ.setdefault(k, v)


_HERE = pathlib.Path(__file__).resolve().parent
_load_env_file(_HERE / ".env")

REPO = os.environ.get("REPO", "A-Su11y/zomboid-mods")
GITHUB_API = os.environ.get("GITHUB_API", "https://api.github.com")
RAW_BASE = f"https://raw.githubusercontent.com/{REPO}/main"
MODS_DIR_RAW = os.environ.get("MODS_DIR")
if not MODS_DIR_RAW:
    print("ERROR: MODS_DIR not set (see .env.example)", file=sys.stderr)
    sys.exit(1)
MODS_DIR = pathlib.Path(MODS_DIR_RAW)

REFRESH_SECONDS = 60
HTTP_TIMEOUT = 5


# --- state -------------------------------------------------------------------

STATE: dict = {
    "repo": REPO,
    "release": None,
    "manifest": None,
    "branches": [],
    "commits": [],
    "mods": [],
    "last_refreshed": None,
    "last_error": None,
    "mods_dir": str(MODS_DIR),
}

_state_lock = threading.Lock()


# --- data gather helpers -----------------------------------------------------

_SESSION = requests.Session()
_SESSION.headers.update({
    "Accept": "application/vnd.github+json",
    "User-Agent": "zomboid-mods-dashboard/1.0",
})


def _get_json(url: str):
    r = _SESSION.get(url, timeout=HTTP_TIMEOUT)
    r.raise_for_status()
    return r.json()


def _get_text(url: str) -> str:
    r = _SESSION.get(url, timeout=HTTP_TIMEOUT)
    r.raise_for_status()
    return r.text


def _mod_sync_status(name: str, manifest: dict) -> dict:
    entry = next((m for m in manifest.get("mods", []) if m["name"] == name), None)
    live_version = None
    live_hash = None
    vf = MODS_DIR / name / ".zm-version"
    if vf.is_file():
        try:
            raw = vf.read_text(encoding="utf-8").strip()
            if ":" in raw:
                v, h = raw.split(":", 1)
                live_version = v.strip()
                live_hash = h.strip()
        except OSError:
            pass

    present = (MODS_DIR / name).is_dir()
    want_version = str(entry["version"]) if entry else None
    want_hash = entry["hash"] if entry else None
    in_sync = bool(
        entry
        and live_version == want_version
        and live_hash == want_hash
    )

    return {
        "name": name,
        "present_on_disk": present,
        "released": entry is not None,
        "live_version": live_version,
        "want_version": want_version,
        "in_sync": in_sync,
        "zip": entry["zip"] if entry else None,
    }


def _notes_excerpt(name: str) -> dict | None:
    url = f"{RAW_BASE}/mods/{name}/NOTES.md"
    try:
        body = _get_text(url)
    except requests.RequestException:
        return None
    snippet = body[:200]
    html = md.markdown(snippet, extensions=["fenced_code"])
    truncated = len(body) > 200
    return {"html": html, "truncated": truncated, "url": f"https://github.com/{REPO}/blob/main/mods/{name}/NOTES.md"}


def _collect_mod_names(manifest: dict) -> list[str]:
    # Only mods we actually patch (i.e. appear in the manifest). Iterating
    # every folder in MODS_DIR would include ~700 upstream mods that aren't
    # ours and would 404-storm on NOTES.md.
    return sorted({m["name"] for m in manifest.get("mods", [])})


# --- refresh -----------------------------------------------------------------

def refresh() -> None:
    errors: list[str] = []

    release = None
    try:
        release = _get_json(f"{GITHUB_API}/repos/{REPO}/releases/latest")
    except requests.RequestException as e:
        errors.append(f"releases/latest: {e}")

    manifest: dict = {"mods": []}
    try:
        manifest = json.loads(_get_text(f"{RAW_BASE}/dist/manifest.json"))
    except (requests.RequestException, ValueError) as e:
        errors.append(f"manifest.json: {e}")

    branches: list = []
    try:
        all_branches = _get_json(f"{GITHUB_API}/repos/{REPO}/branches?per_page=100")
        branches = [b for b in all_branches if b.get("name", "").startswith("patch/")]
    except requests.RequestException as e:
        errors.append(f"branches: {e}")

    commits: list = []
    try:
        commits_raw = _get_json(f"{GITHUB_API}/repos/{REPO}/commits?per_page=10")
        for c in commits_raw:
            commits.append({
                "sha": c["sha"][:7],
                "sha_full": c["sha"],
                "message": c["commit"]["message"].splitlines()[0],
                "author": c["commit"]["author"].get("name", "?"),
                "date": c["commit"]["author"].get("date"),
                "url": c["html_url"],
            })
    except requests.RequestException as e:
        errors.append(f"commits: {e}")

    mod_names = _collect_mod_names(manifest)
    mods = []
    for name in mod_names:
        row = _mod_sync_status(name, manifest)
        row["notes"] = _notes_excerpt(name)
        row["url"] = f"https://github.com/{REPO}/tree/main/mods/{name}"
        mods.append(row)

    now = datetime.now(timezone.utc).isoformat(timespec="seconds")

    with _state_lock:
        if release is not None:
            STATE["release"] = {
                "tag": release.get("tag_name"),
                "name": release.get("name"),
                "published_at": release.get("published_at"),
                "html_url": release.get("html_url"),
            }
        if manifest.get("mods") is not None:
            STATE["manifest"] = manifest
        if branches is not None and "branches" not in [e.split(":")[0] for e in errors]:
            STATE["branches"] = [
                {
                    "name": b["name"],
                    "url": f"https://github.com/{REPO}/tree/{b['name']}",
                    "sha": b.get("commit", {}).get("sha", "")[:7],
                }
                for b in branches
            ]
        if commits:
            STATE["commits"] = commits
        STATE["mods"] = mods
        STATE["last_refreshed"] = now
        STATE["last_error"] = {"when": now, "detail": "; ".join(errors)} if errors else None


def _refresh_loop() -> None:
    while True:
        time.sleep(REFRESH_SECONDS)
        try:
            refresh()
        except Exception as e:  # never crash the thread
            with _state_lock:
                STATE["last_error"] = {
                    "when": datetime.now(timezone.utc).isoformat(timespec="seconds"),
                    "detail": f"refresh loop: {e}",
                }


# --- flask -------------------------------------------------------------------

app = Flask(__name__)


@app.route("/")
def index():
    with _state_lock:
        snapshot = json.loads(json.dumps(STATE))  # deep copy
    return render_template("index.html", s=snapshot)


@app.route("/api/status")
def api_status():
    with _state_lock:
        return jsonify(STATE)


@app.route("/healthz")
def healthz():
    return "ok", 200


# --- entry -------------------------------------------------------------------

def _bootstrap() -> None:
    refresh()  # block for first fetch
    t = threading.Thread(target=_refresh_loop, name="refresh", daemon=True)
    t.start()


_bootstrap()


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8086, debug=False)
