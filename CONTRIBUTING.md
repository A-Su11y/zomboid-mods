# Contributing

This repo has two maintainers working in parallel. Keep this short list in
your head and nothing will collide.

## Before your first contribution

1. You have been added as a collaborator on `A-Su11y/zomboid-mods` (ask if
   not — you need write access to push branches).
2. Clone the repo somewhere, e.g. `~/Projects/zomboid-mods`.
3. Install the tools:
   - **Git**: should be already installed.
   - **GitHub CLI**: `winget install GitHub.cli` on Windows,
     `brew install gh` on Mac. Then `gh auth login`.
   - **PowerShell 5.1+** on Windows (shipped). Mac maintainer can run
     `build.ps1` under PowerShell 7 (`brew install --cask powershell`).
4. Start a Claude session **inside** the repo directory. The `CLAUDE.md`
   there is the project cheat sheet — Claude reads it automatically.

## Branch, don't push to main

```bash
git checkout main
git pull
git checkout -b patch/<mod-slug>-<topic>
```

Example: `patch/gunsofmarz-ammo-box-recipe`.

Push the branch, open a PR, merge after a quick look. Only merged PRs land on
`main`. Only `main` triggers the release workflow (via `build.ps1`).

## Making the actual change

1. Edit `mods/<ModName>/patched/...`. **Never** touch `original/`.
2. Update `mods/<ModName>/NOTES.md` — add a dated entry describing what you
   changed and why. The maintainer who releases later should be able to
   recreate your decision from this file alone.
3. Keep the diff small. One bug = one patch. If you spot a second bug, open a
   second branch for it.

## Releasing

Only one person releases at a time. If someone else's PR is open, merge or
coordinate first.

```powershell
# From main, after the merge
git pull
.\scripts\build.ps1
```

This commits an updated `dist/manifest.json`, tags, pushes, and creates a
GitHub release with the zips.

## What NOT to do

- **Don't rename** mod folders. The folder name is the mod ID — renaming
  breaks clients.
- **Don't edit `dist/*.zip`** by hand. They're generated.
- **Don't commit** anything from `tools/.env`, server IPs, SSH keys, panel
  passwords. The repo is public.
- **Don't mass-reformat** files. A minimal diff makes it obvious to a future
  reader what the patch was for.
- **Don't `docker compose stop pz-server`** on the server host — the image
  has no SIGTERM handler and the world will not save. See
  `docs/SERVER-SYNC.md` for the right way to restart.

## Checking what you shipped

After a release, verify from any browser:

```
https://github.com/A-Su11y/zomboid-mods/releases
https://raw.githubusercontent.com/A-Su11y/zomboid-mods/main/dist/manifest.json
```

Both should show your new version.

## Questions

If something isn't in `CLAUDE.md` or here, ask the other maintainer directly.
Don't guess at server-side details — they're deliberately not in this repo.
