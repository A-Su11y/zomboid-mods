# Server sync (manual, by policy)

The dedicated server runs the same mod bundle as the frozen clients, but
**does not auto-update**. Patches are deployed by hand after the team
agrees to roll one out, so clients and server move together. See
`CONTRIBUTING.md` for the full policy.

## Install (one time, on the server host)

SSH to the server host and drop the updater script somewhere permanent,
e.g. `~/zm-update/update-server-mods.sh`. Copy `tools/.env.example` next
to it as `.env`, fill in `MODS_DIR`, and `chmod 600 .env`.

**Do not add a cron entry.** The script is manual by design.

## Rolling out a release

When the team has agreed to roll out release `vXXX`:

1. Announce "rolling out in 60s" in chat so players don't launch mid-swap.
2. Stop active play (ask players to log out, or `rcon quit` to save +
   bring the server down cleanly).
3. On the server host:

   ```bash
   ~/zm-update/update-server-mods.sh
   ```

   It reads the manifest, pulls any changed mods, and writes a
   `.zm-version` into each updated mod folder.

4. Restart the server (via the mod panel, or `docker compose up -d`
   after a clean stop).
5. Confirm in chat; players can launch now.

## Critical server trap

**Never** `docker compose stop pz-server` on an active server — the image
has no SIGTERM handler, so after 120s it gets SIGKILLed without saving
the world. Save first:

- Use the mod panel's "Save & Restart" button, OR
- Run `rcon quit` from a shell with RCON configured — this saves cleanly
  and then exits.

## Verifying both sides agree

After a rollout:

- The LAN dashboard (`http://192.168.1.220:8086`) should flip from amber
  ("ready to roll out") to green ("you're all set").
- Each `.zm-version` file inside each mod folder on both sides should
  match the manifest's `version` + `hash`.
