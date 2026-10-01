# BMAX server sync

The dedicated server at `192.168.1.220` runs the same mod bundle as the
frozen clients. It uses the same manifest to pick up patches.

## Install (one time)

SSH to the BMAX and drop the updater script somewhere permanent, e.g.
`/home/sculky/zm-update/update-server-mods.sh`. See
`tools/update-server-mods.sh` in this repo for the exact script — it is
the same shape as the client updater but targets the server's SELF_MANAGED_MODS
directory.

Set an env var or edit the script with:

- `REPO=OWNER/REPO`
- `MODS_DIR=/path/to/pz-server/mods`

Add to crontab (hourly):

```cron
15 * * * * /home/sculky/zm-update/update-server-mods.sh >> /home/sculky/zm-update/last.log 2>&1
```

## When a restart is needed

PZ loads mods on process start. The updater only replaces files on disk; the
running server keeps the old versions until restart. Restart via the mod panel
at `http://192.168.1.220:8085` or via `rcon quit` from the server shell.

**Never** `docker compose stop pz-server` — the image has no SIGTERM handler,
so the server gets SIGKILLed after 120s without saving. `rcon quit` saves
first, then exits cleanly.

## Verifying both sides agree

After a release:

- Server: `/home/sculky/zm-update/update-server-mods.sh` (cron will do it too).
- Clients: double-click their Desktop updater.
- The `.zm-version` file inside each mod folder on both sides should match
  the manifest's `version` + `hash`.
