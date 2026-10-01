# dashboard — "where was I"

A one-page Flask dashboard that lives on the Zomboid server host and tells
you, at a glance, where things stand with the frozen modpack.

Open it on your phone, your TV, or the laptop you forgot to close yesterday.
No login, no fuss. It is read-only and expects to run on your LAN only.

## What it shows

- **Status bar** — latest release tag, mods tracked, patches in progress.
- **Work in progress** — any open `patch/*` branches on GitHub.
- **Mods** — every mod in the manifest and/or on the server, with a sync
  indicator (green `in sync`, amber `drift` or `missing`, grey `unreleased`),
  plus the first 200 chars of each mod's `NOTES.md`.
- **Cheat sheet** — the four commands you will forget: start a patch,
  release, how clients update, how the server picks up patches.
- **Recent activity** — last 10 commits with author and timestamp.

The page auto-refreshes every 30 seconds. Data is pulled from the public
GitHub repo and the local `MODS_DIR` on the server; the backend refreshes
state in the background every 60 seconds so page loads are instant.

## Install

See `deploy/install.sh` in this repo. The short version: clone the repo on
your server, copy `dashboard/.env.example` to `dashboard/.env` and fill in
`MODS_DIR`, then enable the systemd unit the installer drops in.

## Configuration

Set via a `.env` next to `app.py` or via the environment:

| Variable     | Required | Default                   | Purpose                                                    |
|--------------|----------|---------------------------|------------------------------------------------------------|
| `MODS_DIR`   | yes      | —                         | Absolute path to the server's SELF_MANAGED_MODS directory. |
| `REPO`       | no       | `A-Su11y/zomboid-mods`    | GitHub owner/name to pull manifest/releases from.          |
| `GITHUB_API` | no       | `https://api.github.com`  | Override when testing against a fork or mock.              |

## LAN-only, please

The dashboard has no authentication. It exposes the server's mods directory
path and the state of the running world. Do not forward port `8086` to the
internet. If you must reach it off-LAN, put it behind Tailscale or a VPN.

## Development

```
pip install -r requirements.txt
cp .env.example .env   # edit MODS_DIR
python app.py          # http://localhost:8086
```

JSON mirror of the current state is at `/api/status`.
Liveness probe is at `/healthz`.
