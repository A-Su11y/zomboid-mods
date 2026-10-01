# Server sync

The dedicated server runs the same mod bundle as the frozen clients and uses
the same manifest to pick up patches.

## Install (one time)

SSH to the server host and drop the updater script somewhere permanent, e.g.
`~/zm-update/update-server-mods.sh`. Copy `tools/.env.example` next to it as
`.env`, fill in `MODS_DIR`, and `chmod 600 .env`.

Then add to crontab (hourly):

```cron
15 * * * * ~/zm-update/update-server-mods.sh >> ~/zm-update/last.log 2>&1
```

The script reads `.env` from the same directory, so no secrets ever end up
in `crontab` or process listings.

## When a restart is needed

PZ loads mods on process start. The updater only replaces files on disk; the
running server keeps the old versions until restart.

**Never** `docker compose stop pz-server` — the image has no SIGTERM handler,
so the server gets SIGKILLed after 120s without saving. Use the mod panel
restart or run `rcon quit` from the server shell first (that saves cleanly,
then exits).

## Verifying both sides agree

After a release:

- Server: run the updater (cron will do it too within the hour).
- Clients: double-click their Desktop updater.
- The `.zm-version` file inside each mod folder on both sides should match
  the manifest's `version` + `hash`.
