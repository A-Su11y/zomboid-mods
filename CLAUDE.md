# zomboid-mods

Patches for a frozen Project Zomboid B42 modpack. Public repo. Companion to
a self-hosted dedicated server and ~5 pinned client installs that must stay
byte-identical with it.

**Read this before touching anything.** The parent `ClaudeHQ/CLAUDE.md` still
loads on top of this for machine context; this file is project-specific only.

## The flow in one paragraph

Maintainer edits `mods/<ModName>/patched/`. Runs `.\scripts\build.ps1`. That
hashes `patched/`, bumps the mod's version if the hash changed, zips it,
updates `dist/manifest.json`, commits, pushes, and creates a GitHub release
with the zip attached. Friends and the server each run their own
`update-frozen-zomboid.*` or `update-server-mods.sh` which read the manifest
from `raw.githubusercontent.com` and pull only the changed zips. Nothing else
has to happen.

## Layout

```
mods/<ModName>/
  original/   pristine copy from the frozen bundle (reference, for diff)
  patched/    our edited copy — this is what ships
  NOTES.md    bug description + hypotheses + what we changed
scripts/      build.ps1 (release), update-frozen-zomboid.{ps1,sh} (clients)
tools/        sync-originals.ps1 (refresh originals from local bundle),
              update-server-mods.sh (server-side updater)
docs/         FRIEND-SETUP.md, SERVER-SYNC.md
dist/         manifest.json (committed), *.zip (gitignored — published via Releases)
```

## Hard rules

- **Edit `patched/`, never `original/`.** `original/` is the reference for
  diffs. If you need a fresh baseline, run `tools\sync-originals.ps1`.
- **One mod per release is fine; one branch per concurrent patch** so parallel
  contributors don't collide. Use `patch/<mod-slug>-<topic>`.
- **Never commit anything matching `tools/.env`, `.env`, server IPs, hostnames,
  usernames, or paths.** The repo is public. Server-specific paths live in a
  local `.env` on the server, read by `update-server-mods.sh` at runtime. See
  `tools/.env.example` for the shape.
- **Never bulk-rewrite a mod file.** Minimal diff vs `original/` is the whole
  point — a smaller diff is easier for the mod author to accept upstream later
  and easier for us to re-base when the Workshop version updates.
- **Clients and server must agree.** A patch released via `build.ps1` will
  propagate to both sides automatically; manual edits on either side will
  cause a version mismatch and players will fail to join.

## Server traps (critical)

- The PZ server image has **no SIGTERM handler**. `docker compose stop` sends
  SIGTERM, waits 120s, then SIGKILLs — the world is NOT saved. Use the mod
  panel restart button, or run `rcon quit` first (saves cleanly, then exits).
- The server runs with `SELF_MANAGED_MODS=true`. The Workshop subscription
  path is never used; mods live on disk in a specific directory the server
  reads at start.
- Mods are only (re)loaded on process start. The updater script replaces files
  but the running server keeps the old copy in memory until restart.

## Common tasks

### Start a new patch

```powershell
cd workspace\zomboid-mods
git checkout -b patch/<mod-slug>-<topic>
# refresh the pristine reference if the mod has been updated upstream
.\tools\sync-originals.ps1
# edit mods\<ModName>\patched\...
# update mods\<ModName>\NOTES.md with what's wrong and what you changed
```

### Release

```powershell
.\scripts\build.ps1          # dry: builds + manifest + release
.\scripts\build.ps1 -DryRun  # build only, no git/gh
```

`build.ps1` auto-detects which mods changed by hashing `patched/`. Unchanged
mods keep their version number — no spurious releases.

### Diff vs original

```powershell
# For a single mod:
Compare-Object (Get-ChildItem mods\<Name>\original -Recurse) (Get-ChildItem mods\<Name>\patched -Recurse) -Property Name,Length
# Or:
git diff --no-index mods\<Name>\original mods\<Name>\patched
```

### Add a new mod to the repo

1. Pick its folder name from the frozen bundle (the Workshop name, exact case).
2. `New-Item -ItemType Directory mods\<Name>`
3. Copy the mod into `mods\<Name>\original\` AND `mods\<Name>\patched\`.
4. Write `mods\<Name>\NOTES.md` describing the bug.
5. Commit the baseline before patching — makes the diff cleaner.
6. Patch, then `build.ps1`.

## Context pointers

- Public release URLs: `https://github.com/A-Su11y/zomboid-mods/releases`
- Public manifest: `https://raw.githubusercontent.com/A-Su11y/zomboid-mods/main/dist/manifest.json`
- Frozen client kit (not in this repo): `A:\ZomboidFrozen\` on the maintainer's
  machine — contains the server-canonical mod bundle used by `sync-originals.ps1`.
- The frozen clients and server are set up by scripts that live elsewhere;
  this repo is strictly about patches, not initial setup.

## Not in scope

- Initial frozen-client setup — that is `A:\ZomboidFrozen\freeze_client_*`.
- Server image, panel, docker-compose — see the server project in the
  maintainer's workspace.
- Workshop mod authoring from scratch — this repo only patches existing mods.
- Rebalance, new content — only recipe/compat/bug fixes.
