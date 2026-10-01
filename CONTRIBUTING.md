# Contributing

Two maintainers work in parallel on this repo. Keep this list in your head
and nothing will collide.

## Core policy — read first

- **No auto-updates on the server.** Patches are released on GitHub, but the
  server does **not** sync on a cron. Nothing goes live until the team agrees.
- **Everyone rolls out together.** When a patch is approved, every player
  double-clicks their updater *and* the server operator runs the server sync
  at roughly the same time. Players whose version drifts from the server will
  fail to join.
- **Test locally before you release.** See "Testing" below. Don't push a
  patch to `main` or cut a release until you've seen it work in your own
  frozen client.

## Before your first contribution

1. Ask barti to add you as a collaborator on `A-Su11y/zomboid-mods` — you
   need write access to push branches.
2. Clone the repo somewhere, e.g. `~/Projects/zomboid-mods`.
3. Install the tools:
   - **Git** (should already be installed).
   - **GitHub CLI**: `winget install GitHub.cli` on Windows,
     `brew install gh` on Mac. Then `gh auth login`.
   - **PowerShell 5.1+** (Windows ships this). Mac can run `build.ps1` under
     PowerShell 7 (`brew install --cask powershell`).
4. Start a Claude session **inside** the repo directory. The `CLAUDE.md`
   there is the project cheat sheet — Claude reads it automatically.

## Branch, don't push to main

```bash
git checkout main
git pull
git checkout -b patch/<mod-slug>-<topic>
```

Example: `patch/gunsofmarz-ammo-box-recipe`.

## Making the actual change

1. Edit `mods/<ModName>/patched/...`. **Never** touch `original/`.
2. Update `mods/<ModName>/NOTES.md` — add a dated entry describing what you
   changed and why. The maintainer who releases later should be able to
   recreate your decision from this file alone.
3. Keep the diff small. One bug = one patch. If you spot a second bug, open
   a second branch for it.

## Testing

Before you merge or release, overlay your patched mod onto your own frozen
client and try it in-game:

**Windows**

```powershell
.\scripts\test-local.ps1 <ModName>
```

**Mac**

```bash
./scripts/test-local.sh <ModName>
```

This copies `mods/<ModName>/patched/` into your frozen `userprofile/mods/`
and marks it with a `test-overlay` version so your normal updater knows to
replace it later. **It does not touch any other mod.**

Then launch Zomboid via your frozen Desktop shortcut and test. For recipe
and script fixes, a sandbox single-player world is enough.

To revert to the released version at any time: double-click the "Update
Frozen Zomboid" shortcut on your Desktop. It will overwrite the overlay
with the released content.

**What a local overlay cannot test**: multiplayer-only bugs like desyncs
or "mod version mismatch" join errors. For those, we'd need a dev server
(we don't have one yet — ask barti if your patch depends on this).

## Opening a PR

1. Push your branch: `git push -u origin HEAD`.
2. Open a PR against `main` on GitHub.
3. In the PR description, say what the patch does and that you've
   tested it locally.
4. Tag the other maintainer for review.
5. **Don't** self-merge non-trivial changes — recipe/script fixes
   benefit from a second pair of eyes.

## Releasing

Only after the PR is merged, and only one person at a time (coordinate on
chat first):

```powershell
# From main, after the merge
git pull
.\scripts\build.ps1
```

This commits an updated `dist/manifest.json`, tags, pushes, and creates a
GitHub release with the zips. **The release does NOT deploy anything** —
it just makes the zip available for everyone to pull when the team agrees.

## Rolling out

After the release:

1. Announce in chat: "release vXXX ready, rolling out at <time>."
2. At the agreed time, everyone (players + server operator) runs their
   updater at roughly the same moment:
   - **Players** — double-click Desktop "Update Frozen Zomboid".
   - **Server operator** — SSH to the server host and run the server
     updater once. See `docs/SERVER-SYNC.md`.
3. The dashboard flips from amber to green when the server is in sync.
   Confirm in chat and start the game.

## What NOT to do

- **Don't rename** mod folders. The folder name is the mod ID — renaming
  breaks clients.
- **Don't edit `dist/*.zip`** by hand. They're generated.
- **Don't commit** anything from `tools/.env`, server IPs, SSH keys, panel
  passwords. The repo is public.
- **Don't mass-reformat** files. A minimal diff makes it obvious to a
  future reader what the patch was for.
- **Don't deploy to the server without the team's agreement.** See the
  core policy at the top.

## Checking what you shipped

After a release:

```
https://github.com/A-Su11y/zomboid-mods/releases
http://192.168.1.220:8086        # LAN-only dashboard
```

Dashboard will say "ready to roll out" until the server is synced.
