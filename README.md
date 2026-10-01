# zomboid-mods

Patches for the frozen Project Zomboid B42 modpack we run on our server.

Each mod we patch lives under `mods/<ModName>/` with a pristine copy and the
patched copy side-by-side, so diffs are explicit and auditable.

## Layout

```
mods/<ModName>/
  original/   pristine copy from the frozen bundle (reference, for diff)
  patched/    our edited copy — this is what ships
  NOTES.md    what's wrong, what we changed, why
```

## For players — how to update

You only ever run **one** script: the updater on your Desktop.

- **Windows**: double-click `Update Frozen Zomboid.lnk`
- **Mac**: double-click `Update Frozen Zomboid.command`

It pulls the latest manifest from GitHub, compares to what you have, and
replaces only the mod folders that changed. Nothing else is touched.

See `docs/FRIEND-SETUP.md` for first-time install.

## For me — how to publish a patch

1. Edit files under `mods/<ModName>/patched/`.
2. Update `mods/<ModName>/NOTES.md` with what changed.
3. From the repo root:

   ```powershell
   .\scripts\build.ps1
   ```

   This bumps versions for mods whose `patched/` hash changed, writes
   `dist/manifest.json`, builds per-mod zips in `dist/`, commits, tags, and
   pushes a GitHub release with the zips attached.

4. Tell players "update released, double-click your shortcut."

## For the server

The BMAX pulls the same manifest via cron and refreshes mods on the next
scheduled restart. See `docs/SERVER-SYNC.md`.
