#!/usr/bin/env python3
"""Local control panel for zomboid-mods.

Runs on 127.0.0.1:8087 ONLY. Never binds publicly. Drives common operations
(update local, launch game, test a patch, release, deploy to server) by
invoking the existing repo scripts as subprocesses.
"""
from __future__ import annotations

import json
import os
import pathlib
import re
import subprocess
import sys
import threading
import time
from collections import deque
from datetime import datetime, timezone

import bleach
import markdown as md

# Allow-list for NOTES.md HTML — safe subset for display.
_ALLOWED_TAGS = ["p", "code", "pre", "em", "strong", "ul", "ol", "li", "a", "br", "blockquote", "h3", "h4"]
_ALLOWED_ATTRS = {"a": ["href", "title"]}


def _sanitize_markdown(text: str) -> str:
    raw_html = md.markdown(text, extensions=["fenced_code"])
    return bleach.clean(raw_html, tags=_ALLOWED_TAGS, attributes=_ALLOWED_ATTRS, strip=True)
import requests
from flask import Flask, abort, jsonify, render_template, request


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

FROZEN_ROOT = os.environ.get("FROZEN_ROOT")
if not FROZEN_ROOT:
    print("ERROR: FROZEN_ROOT not set (see .env.example)", file=sys.stderr)
    sys.exit(1)
FROZEN_ROOT = pathlib.Path(FROZEN_ROOT)

REPO_ROOT = os.environ.get("REPO_ROOT")
if not REPO_ROOT:
    print("ERROR: REPO_ROOT not set (see .env.example)", file=sys.stderr)
    sys.exit(1)
REPO_ROOT = pathlib.Path(REPO_ROOT)

SERVER_SSH = os.environ.get("SERVER_SSH", "")
LAN_DASHBOARD_URL = os.environ.get("LAN_DASHBOARD_URL", "http://192.168.1.220:8086")

# MODS_DIR reflects *this laptop's* frozen client, for sync-status display.
MODS_DIR_RAW = os.environ.get("MODS_DIR") or str(FROZEN_ROOT / "userprofile" / "mods")
MODS_DIR = pathlib.Path(MODS_DIR_RAW)

REFRESH_SECONDS = 60
HTTP_TIMEOUT = 5

IS_WINDOWS = sys.platform.startswith("win")


# --- state -------------------------------------------------------------------

STATE: dict = {
    "repo": REPO,
    "release": None,
    "manifest": None,
    "branches": [],
    "commits": [],
    "mods": [],
    "last_refreshed": None,
    "last_refreshed_rel": None,
    "last_error": None,
    "mods_dir": str(MODS_DIR),
    "ready_to_roll_out": False,
}

_state_lock = threading.Lock()


# --- data gather helpers -----------------------------------------------------

_SESSION = requests.Session()
_SESSION.headers.update({
    "Accept": "application/vnd.github+json",
    "User-Agent": "zomboid-mods-panel/1.0",
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
    """Return the first real paragraph of NOTES.md (skip title + first subheader)."""
    url = f"{RAW_BASE}/mods/{name}/NOTES.md"
    try:
        body = _get_text(url)
    except requests.RequestException:
        return None
    lines = body.splitlines()
    buf: list[str] = []
    started = False
    for ln in lines:
        stripped = ln.strip()
        if not started:
            if not stripped or stripped.startswith("#"):
                continue
            started = True
            buf.append(stripped)
            continue
        if not stripped:
            break
        buf.append(stripped)
    paragraph = " ".join(buf).strip() or body[:200]
    if len(paragraph) > 400:
        paragraph = paragraph[:400].rsplit(" ", 1)[0] + "…"
    return {
        "html": _sanitize_markdown(paragraph),
        "url": f"https://github.com/{REPO}/blob/main/mods/{name}/NOTES.md",
    }


def _humanize_name(name: str) -> str:
    s = re.sub(r"([a-z0-9])([A-Z])", r"\1 \2", name)
    s = re.sub(r"([A-Z]+)([A-Z][a-z])", r"\1 \2", s)
    s = s.replace("_", " ")
    return s


def _relative_time(iso_str: str | None) -> str:
    if not iso_str:
        return ""
    try:
        if iso_str.endswith("Z"):
            t = datetime.fromisoformat(iso_str.replace("Z", "+00:00"))
        else:
            t = datetime.fromisoformat(iso_str)
    except ValueError:
        return iso_str
    now = datetime.now(timezone.utc)
    delta = now - t
    secs = int(delta.total_seconds())
    if secs < 60:
        return "just now"
    if secs < 3600:
        m = secs // 60
        return f"{m} minute{'s' if m != 1 else ''} ago"
    if secs < 86400:
        h = secs // 3600
        return f"{h} hour{'s' if h != 1 else ''} ago"
    days = secs // 86400
    if days < 14:
        return f"{days} day{'s' if days != 1 else ''} ago"
    weeks = days // 7
    if weeks < 8:
        return f"{weeks} week{'s' if weeks != 1 else ''} ago"
    return t.strftime("%Y-%m-%d")


def _collect_mod_names(manifest: dict) -> list[str]:
    # Patched mods from the manifest, plus any folder under repo/mods/ that
    # has a patched/ subdir (local-only drafts not yet released).
    names: set[str] = {m["name"] for m in manifest.get("mods", [])}
    mods_dir = REPO_ROOT / "mods"
    if mods_dir.is_dir():
        for p in mods_dir.iterdir():
            if p.is_dir() and (p / "patched").is_dir():
                names.add(p.name)
    return sorted(names)


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
        row["friendly_name"] = _humanize_name(name)
        mods.append(row)

    for c in commits:
        c["relative_time"] = _relative_time(c.get("date"))

    now = datetime.now(timezone.utc).isoformat(timespec="seconds")

    with _state_lock:
        if release is not None:
            STATE["release"] = {
                "tag": release.get("tag_name"),
                "name": release.get("name"),
                "published_at": release.get("published_at"),
                "relative_time": _relative_time(release.get("published_at")),
                "body": release.get("body"),
                "html_url": release.get("html_url"),
            }
        if manifest.get("mods") is not None:
            STATE["manifest"] = manifest
        if "branches" not in [e.split(":")[0] for e in errors]:
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
        STATE["ready_to_roll_out"] = any(not m["in_sync"] for m in mods if m["released"])
        STATE["last_refreshed"] = now
        STATE["last_refreshed_rel"] = _relative_time(now)
        STATE["last_error"] = {"when": now, "detail": "; ".join(errors)} if errors else None


def _refresh_loop() -> None:
    while True:
        time.sleep(REFRESH_SECONDS)
        try:
            refresh()
        except Exception as e:
            with _state_lock:
                STATE["last_error"] = {
                    "when": datetime.now(timezone.utc).isoformat(timespec="seconds"),
                    "detail": f"refresh loop: {e}",
                }


# --- action runner -----------------------------------------------------------

ACTIONS: dict[str, dict] = {}
_actions_lock = threading.Lock()
_LOG_CAP = 500


def _any_running() -> str | None:
    with _actions_lock:
        for aid, a in ACTIONS.items():
            if a["status"] == "running":
                return aid
    return None


def _new_action(kind: str, cmd: list[str], cwd: pathlib.Path | None) -> str:
    aid = f"{int(time.time())}-{kind}"
    now = datetime.now(timezone.utc).isoformat(timespec="seconds")
    with _actions_lock:
        ACTIONS[aid] = {
            "id": aid,
            "kind": kind,
            "cmd": cmd,
            "cwd": str(cwd) if cwd else None,
            "status": "running",
            "exit_code": None,
            "lines": deque(maxlen=_LOG_CAP),
            "started": now,
            "finished": None,
        }
    t = threading.Thread(target=_run_action, args=(aid, cmd, cwd), daemon=True)
    t.start()
    return aid


def _run_action(aid: str, cmd: list[str], cwd: pathlib.Path | None) -> None:
    try:
        with _actions_lock:
            ACTIONS[aid]["lines"].append(f"$ {' '.join(cmd)}")
            if cwd:
                ACTIONS[aid]["lines"].append(f"(cwd: {cwd})")
        proc = subprocess.Popen(
            cmd,
            cwd=str(cwd) if cwd else None,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            bufsize=1,
            text=True,
            encoding="utf-8",
            errors="replace",
        )
        assert proc.stdout is not None
        for line in proc.stdout:
            with _actions_lock:
                ACTIONS[aid]["lines"].append(line.rstrip())
        rc = proc.wait()
        with _actions_lock:
            ACTIONS[aid]["exit_code"] = rc
            ACTIONS[aid]["status"] = "done" if rc == 0 else "error"
            ACTIONS[aid]["finished"] = datetime.now(timezone.utc).isoformat(timespec="seconds")
    except Exception as e:
        with _actions_lock:
            ACTIONS[aid]["lines"].append(f"[panel] exception: {e}")
            ACTIONS[aid]["status"] = "error"
            ACTIONS[aid]["exit_code"] = -1
            ACTIONS[aid]["finished"] = datetime.now(timezone.utc).isoformat(timespec="seconds")


def _ps(script: pathlib.Path, *args: str) -> list[str]:
    return [
        "powershell.exe", "-NoProfile", "-ExecutionPolicy", "Bypass",
        "-File", str(script), *args,
    ]


def _sh(script: pathlib.Path, *args: str) -> list[str]:
    return ["bash", str(script), *args]


def _run_script(name: str) -> pathlib.Path:
    ext = ".ps1" if IS_WINDOWS else ".sh"
    return REPO_ROOT / "scripts" / f"{name}{ext}"


# --- flask -------------------------------------------------------------------

app = Flask(__name__)


@app.route("/")
def index():
    with _state_lock:
        snapshot = json.loads(json.dumps(STATE))
    return render_template(
        "index.html",
        s=snapshot,
        lan_dashboard=LAN_DASHBOARD_URL,
        has_server_ssh=bool(SERVER_SSH),
    )


@app.route("/api/status")
def api_status():
    with _state_lock:
        payload = json.loads(json.dumps(STATE))
    payload["running_action"] = _any_running()
    return jsonify(payload)


@app.route("/api/action/<aid>")
def api_action(aid):
    with _actions_lock:
        a = ACTIONS.get(aid)
        if not a:
            abort(404)
        return jsonify({
            "id": a["id"],
            "kind": a["kind"],
            "status": a["status"],
            "exit_code": a["exit_code"],
            "lines": list(a["lines"]),
            "started": a["started"],
            "finished": a["finished"],
        })


def _guard_single():
    aid = _any_running()
    if aid:
        return jsonify({"error": "another action is running", "running_id": aid}), 409
    return None


def _confirmed() -> bool:
    try:
        body = request.get_json(silent=True) or {}
    except Exception:
        body = {}
    return bool(body.get("confirm"))


# CSRF defense: /action/* endpoints must be invoked with a JSON Content-Type.
# That forces browsers to do a CORS preflight on cross-origin fetches, which
# the same-origin policy blocks. A malicious website visited by the user
# cannot submit a plain-form POST that triggers an action.
@app.before_request
def _enforce_json_on_actions():
    if request.path.startswith("/action/"):
        ctype = (request.content_type or "").split(";")[0].strip().lower()
        if ctype != "application/json":
            return jsonify({"error": "action endpoints require Content-Type: application/json"}), 415


@app.route("/action/update-local", methods=["POST"])
def action_update_local():
    err = _guard_single()
    if err:
        return err
    script = _run_script("update-frozen-zomboid")
    if IS_WINDOWS:
        cmd = _ps(script, "-FrozenRoot", str(FROZEN_ROOT))
    else:
        env_prefix = ["env", f"FROZEN_ROOT={FROZEN_ROOT}"]
        cmd = env_prefix + _sh(script)
    aid = _new_action("update-local", cmd, REPO_ROOT)
    return jsonify({"id": aid})


@app.route("/action/launch-game", methods=["POST"])
def action_launch_game():
    err = _guard_single()
    if err:
        return err
    if IS_WINDOWS:
        launcher = FROZEN_ROOT / "LaunchFrozenZomboid.bat"
        if not launcher.is_file():
            return jsonify({"error": f"launcher not found: {launcher}"}), 404
        cmd = ["cmd.exe", "/c", "start", "", str(launcher)]
    else:
        launcher = FROZEN_ROOT / "LaunchFrozenZomboid.command"
        if not launcher.is_file():
            return jsonify({"error": f"launcher not found: {launcher}"}), 404
        cmd = ["bash", str(launcher)]
    aid = _new_action("launch-game", cmd, FROZEN_ROOT)
    return jsonify({"id": aid})


@app.route("/action/test-local", methods=["POST"])
def action_test_local():
    err = _guard_single()
    if err:
        return err
    body = request.get_json(silent=True) or {}
    mod = (body.get("mod") or "").strip()
    if not mod or not re.fullmatch(r"[A-Za-z0-9_\-]+", mod):
        return jsonify({"error": "mod name missing or invalid"}), 400
    if not (REPO_ROOT / "mods" / mod / "patched").is_dir():
        return jsonify({"error": f"no patched/ for {mod}"}), 404
    script = _run_script("test-local")
    if IS_WINDOWS:
        cmd = _ps(script, "-Mod", mod, "-FrozenRoot", str(FROZEN_ROOT))
    else:
        env_prefix = ["env", f"FROZEN_ROOT={FROZEN_ROOT}"]
        cmd = env_prefix + _sh(script, mod)
    aid = _new_action("test-local", cmd, REPO_ROOT)
    return jsonify({"id": aid})


@app.route("/action/release", methods=["POST"])
def action_release():
    if not _confirmed():
        return jsonify({"error": "requires {\"confirm\": true}"}), 400
    err = _guard_single()
    if err:
        return err
    script = REPO_ROOT / "scripts" / "build.ps1"
    cmd = _ps(script)
    aid = _new_action("release", cmd, REPO_ROOT)
    return jsonify({"id": aid})


@app.route("/action/deploy-server", methods=["POST"])
def action_deploy_server():
    if not _confirmed():
        return jsonify({"error": "requires {\"confirm\": true}"}), 400
    if not SERVER_SSH:
        return jsonify({"error": "SERVER_SSH not configured in .env"}), 400
    err = _guard_single()
    if err:
        return err
    cmd = ["ssh", SERVER_SSH, "~/zm-update/update-server-mods.sh"]
    aid = _new_action("deploy-server", cmd, REPO_ROOT)
    return jsonify({"id": aid})


# --- entry -------------------------------------------------------------------

def _bootstrap() -> None:
    try:
        refresh()
    except Exception as e:
        with _state_lock:
            STATE["last_error"] = {
                "when": datetime.now(timezone.utc).isoformat(timespec="seconds"),
                "detail": f"initial refresh: {e}",
            }
    t = threading.Thread(target=_refresh_loop, name="refresh", daemon=True)
    t.start()


_bootstrap()


if __name__ == "__main__":
    app.run(host="127.0.0.1", port=8087, debug=False, use_reloader=False)
