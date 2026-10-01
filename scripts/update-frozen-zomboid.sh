#!/usr/bin/env bash
# update-frozen-zomboid.sh
#
# Pulls the latest patched-mods manifest from GitHub, replaces any mods whose
# version changed, leaves the rest alone. Safe to re-run.
#
# Lives on the Desktop next to "Zomboid (Frozen).command". Double-click.

set -euo pipefail

FROZEN_ROOT="${FROZEN_ROOT:-$HOME/ZomboidFrozen}"
REPO="${REPO:-OWNER/REPO}"     # set at install time

log()  { printf '[update] %s\n' "$*"; }
fail() { printf 'ERROR: %s\n' "$*" >&2; read -r -p "press enter to close " _ || true; exit 1; }

MODS_DIR="$FROZEN_ROOT/userprofile/mods"
[[ -d "$MODS_DIR" ]] || fail "No mods dir at $MODS_DIR - is ZomboidFrozen installed?"

MANIFEST_URL="https://raw.githubusercontent.com/$REPO/main/dist/manifest.json"
log "fetching manifest from $MANIFEST_URL"
MANIFEST_JSON=$(curl -fsSL "$MANIFEST_URL") || fail "could not fetch manifest"

# Parse manifest with python (ships with macOS).
PY=$(command -v python3 || command -v python) || fail "no python on PATH"

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

# Produce lines: NAME<TAB>VERSION<TAB>HASH<TAB>ZIP
printf '%s' "$MANIFEST_JSON" | "$PY" -c '
import json,sys
d=json.load(sys.stdin)
for m in d["mods"]:
    print("\t".join([m["name"], str(m["version"]), m["hash"], m["zip"]]))
' > "$TMP/manifest.tsv"

TO_UPDATE=()
while IFS=$'\t' read -r NAME VERSION HASH ZIP; do
  LIVE="$MODS_DIR/$NAME"
  VF="$LIVE/.zm-version"
  WANT="${VERSION}:${HASH}"
  HAVE=""
  [[ -f "$VF" ]] && HAVE=$(tr -d '[:space:]' < "$VF")
  if [[ "$HAVE" != "$WANT" ]]; then
    TO_UPDATE+=("$NAME"$'\t'"$VERSION"$'\t'"$HASH"$'\t'"$ZIP"$'\t'"$WANT")
  fi
done < "$TMP/manifest.tsv"

if [[ ${#TO_UPDATE[@]} -eq 0 ]]; then
  log "already up to date"
  read -r -p "press enter to close " _ || true
  exit 0
fi

log "${#TO_UPDATE[@]} mod(s) to update:"
for row in "${TO_UPDATE[@]}"; do
  IFS=$'\t' read -r NAME VERSION HASH ZIP WANT <<< "$row"
  log "  - $NAME -> v$VERSION"
done

for row in "${TO_UPDATE[@]}"; do
  IFS=$'\t' read -r NAME VERSION HASH ZIP WANT <<< "$row"
  URL="https://github.com/$REPO/releases/latest/download/$ZIP"
  ZPATH="$TMP/$ZIP"
  log "downloading $ZIP"
  curl -fsSL -o "$ZPATH" "$URL" || fail "download failed: $URL"
  STAGE="$TMP/stage-$NAME"
  mkdir -p "$STAGE"
  (cd "$STAGE" && unzip -q "$ZPATH")
  STAGED="$STAGE/$NAME"
  [[ -d "$STAGED" ]] || fail "zip layout wrong for $NAME"

  LIVE="$MODS_DIR/$NAME"
  if [[ -d "$LIVE" ]]; then
    BAK="$LIVE.old-$(date +%Y%m%d%H%M%S)"
    mv "$LIVE" "$BAK"
  fi
  mv "$STAGED" "$LIVE"
  printf '%s\n' "$WANT" > "$LIVE/.zm-version"
  log "updated $NAME -> v$VERSION"
  rm -rf "$MODS_DIR/$NAME".old-* 2>/dev/null || true
done

log "done. Launch via your Desktop shortcut when ready."
read -r -p "press enter to close " _ || true
