#!/usr/bin/env bash
# update-server-mods.sh
#
# BMAX-side counterpart to the client updater. Pulls the manifest and
# replaces changed mod folders in the server's SELF_MANAGED_MODS directory.
# Safe to re-run; writes no logs beyond stdout.
#
# Install on the BMAX (not committed to run on Windows). Set REPO and MODS_DIR
# via env or edit the two lines below.

set -euo pipefail

REPO="${REPO:-OWNER/REPO}"
MODS_DIR="${MODS_DIR:-/home/sculky/pz-server/mods}"

log()  { printf '[%s] %s\n' "$(date -Is)" "$*"; }
fail() { printf '[%s] ERROR: %s\n' "$(date -Is)" "$*" >&2; exit 1; }

[[ -d "$MODS_DIR" ]] || fail "no mods dir at $MODS_DIR"

MANIFEST=$(curl -fsSL "https://raw.githubusercontent.com/$REPO/main/dist/manifest.json") || fail "manifest fetch failed"

TMP=$(mktemp -d); trap 'rm -rf "$TMP"' EXIT
printf '%s' "$MANIFEST" > "$TMP/manifest.json"

python3 -c '
import json,sys
d=json.load(open(sys.argv[1]))
for m in d["mods"]:
    print("\t".join([m["name"], str(m["version"]), m["hash"], m["zip"]]))
' "$TMP/manifest.json" > "$TMP/manifest.tsv"

CHANGED=0
while IFS=$'\t' read -r NAME VERSION HASH ZIP; do
  LIVE="$MODS_DIR/$NAME"
  VF="$LIVE/.zm-version"
  WANT="${VERSION}:${HASH}"
  HAVE=""
  [[ -f "$VF" ]] && HAVE=$(tr -d '[:space:]' < "$VF")
  if [[ "$HAVE" == "$WANT" ]]; then continue; fi

  URL="https://github.com/$REPO/releases/latest/download/$ZIP"
  log "fetching $ZIP"
  curl -fsSL -o "$TMP/$ZIP" "$URL" || fail "download failed: $URL"
  STAGE="$TMP/stage-$NAME"
  mkdir -p "$STAGE"
  (cd "$STAGE" && unzip -q "$TMP/$ZIP")
  [[ -d "$STAGE/$NAME" ]] || fail "zip layout wrong for $NAME"

  if [[ -d "$LIVE" ]]; then
    rm -rf "$LIVE"
  fi
  mv "$STAGE/$NAME" "$LIVE"
  printf '%s\n' "$WANT" > "$LIVE/.zm-version"
  log "updated $NAME -> v$VERSION"
  CHANGED=$((CHANGED+1))
done < "$TMP/manifest.tsv"

if [[ $CHANGED -gt 0 ]]; then
  log "$CHANGED mod(s) updated - restart pz-server (RCON quit) to apply"
else
  log "no changes"
fi
