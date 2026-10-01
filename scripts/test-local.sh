#!/usr/bin/env bash
# test-local.sh
#
# Overlay a mod's patched/ contents into your local frozen Zomboid install,
# so you can launch and test the patch BEFORE committing/releasing it.
#
# To revert: double-click "Update Frozen Zomboid.command" on your Desktop.
#
# Usage:
#   ./scripts/test-local.sh GunsOfMarz
#   FROZEN_ROOT=/some/other/path ./scripts/test-local.sh GunsOfMarz

set -euo pipefail

MOD="${1:-}"
if [[ -z "$MOD" ]]; then
  echo "usage: $0 <ModName>" >&2
  exit 1
fi

HERE=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
REPO_ROOT=$(dirname "$HERE")
SRC="$REPO_ROOT/mods/$MOD/patched"
if [[ ! -d "$SRC" ]]; then
  echo "ERROR: no patched/ for '$MOD' at $SRC" >&2
  exit 1
fi

FROZEN_ROOT="${FROZEN_ROOT:-$HOME/ZomboidFrozen}"
MODS_DIR="$FROZEN_ROOT/userprofile/mods"
if [[ ! -d "$MODS_DIR" ]]; then
  echo "ERROR: no mods dir at $MODS_DIR - is ZomboidFrozen installed?" >&2
  exit 1
fi

DST="$MODS_DIR/$MOD"
if [[ -d "$DST" ]]; then
  STAMP=$(date +%Y%m%d%H%M%S)
  BAK="$DST.before-test-$STAMP"
  echo "[test-local] backing up current $MOD -> $(basename "$BAK")"
  mv "$DST" "$BAK"
fi

echo "[test-local] overlaying patched/$MOD -> $DST"
mkdir -p "$DST"
# cp -R preserves file structure; faster alternatives work too but this is the
# baseline that always works on macOS.
cp -R "$SRC/." "$DST/"

printf 'test-overlay\n' > "$DST/.zm-version"

echo ""
echo "Done. Launch Zomboid via your Desktop shortcut and test the patch."
echo "To revert to the released version: double-click 'Update Frozen Zomboid.command'."
