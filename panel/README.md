# Zomboid Patches — Control Panel

A **local-only** web UI that drives the common operations for this repo —
updating your frozen client, launching the game, testing a draft patch,
cutting a release, and deploying to the live server.

It runs on `127.0.0.1:8087` on **your laptop**, never on the LAN. It calls
the existing scripts under `scripts/` as subprocesses and streams their
output back into the page.

The LAN dashboard on the BMAX (`:8086`) stays as a read-only status page
for the whole house. This panel is for the maintainers' own machines.

## First-time setup

1. Copy `.env.example` to `.env` and edit:
   - `FROZEN_ROOT` — path to your frozen Zomboid install (e.g.
     `C:\Users\barti\ZomboidFrozen`).
   - `REPO_ROOT` — path to this repo.
   - `SERVER_SSH` — SSH target for the server host (optional, only
     needed if you'll use "Deploy to server"). Leave blank otherwise.
2. Run:

   ```powershell
   .\start.ps1
   ```

   It creates a Python venv, installs Flask, starts the panel, and opens
   your browser. Re-running is idempotent — if the panel is already up it
   just opens the tab.

Optional: pin `start.ps1` to Start, or make a Desktop shortcut that runs
it. The panel keeps running in the background until you reboot (or
`Stop-Process` it manually).

## What each button does

- **🎮 Launch Zomboid** — kicks off your frozen-client launcher
  (`LaunchFrozenZomboid.bat` / `.command`). Same thing as the Desktop
  shortcut.
- **⬇ Update my game** — runs `scripts/update-frozen-zomboid.*` against
  your `FROZEN_ROOT`. Pulls the latest released patches.
- **🧪 Test a patch** — overlays a mod's `patched/` dir onto your frozen
  install so you can try it in-game before releasing. To revert, just
  "Update my game".
- **📦 Release patches** — runs `scripts/build.ps1` from the repo root.
  Zips the patched mods, commits + tags + pushes, and creates a GitHub
  release. Asks for confirmation first.
- **🚀 Deploy to server** — SSHes to `SERVER_SSH` and runs the server-side
  updater. Only do this once the team has agreed and nobody's playing.
  Asks for confirmation first.

## Safety notes

- Only one action runs at a time. Starting a new one while another is
  running returns 409.
- Panel binds to `127.0.0.1` **only**. Do not change that — the actions
  include "run arbitrary scripts" and "SSH to the server". Keep it off
  the LAN.
- No secrets are stored in the panel or in `.env`. SSH and GitHub auth
  come from your user profile.
