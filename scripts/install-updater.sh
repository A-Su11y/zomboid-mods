#!/usr/bin/env bash
# install-updater.sh
#
# One-time setup. Downloads the Zomboid patch updater and puts a double-click
# command on your Desktop. Re-running is safe.
#
# Paste this into Terminal:
#   curl -fsSL https://raw.githubusercontent.com/A-Su11y/zomboid-mods/main/scripts/install-updater.sh | bash
#
# If your frozen install isn't at ~/ZomboidFrozen, set FROZEN_ROOT first:
#   FROZEN_ROOT=/Volumes/External/ZomboidFrozen \
#     curl -fsSL https://.../install-updater.sh | bash

set -euo pipefail

REPO='A-Su11y/zomboid-mods'
FROZEN_ROOT="${FROZEN_ROOT:-$HOME/ZomboidFrozen}"

echo "Installing Zomboid patches updater -> $FROZEN_ROOT"

if [[ ! -d "$FROZEN_ROOT" ]]; then
  echo "WARN: no frozen install at $FROZEN_ROOT"
  echo "If yours is elsewhere, Ctrl-C now and re-run with:"
  echo "  FROZEN_ROOT=/path/to/ZomboidFrozen curl -fsSL ... | bash"
  mkdir -p "$FROZEN_ROOT"
fi

DEST="$FROZEN_ROOT/update-frozen-zomboid.sh"
curl -fsSL "https://raw.githubusercontent.com/$REPO/main/scripts/update-frozen-zomboid.sh" -o "$DEST"
chmod +x "$DEST"
echo "  downloaded updater -> $DEST"

DESK="$HOME/Desktop/Update Frozen Zomboid.command"
cat > "$DESK" <<EOF
#!/usr/bin/env bash
# Launcher wrapper for the Zomboid patches updater.
FROZEN_ROOT="$FROZEN_ROOT" exec "$DEST"
EOF
chmod +x "$DESK"
echo "  created shortcut   -> $DESK"

echo
echo "Done. Each time a patch drops, double-click 'Update Frozen Zomboid.command'"
echo "on your Desktop BEFORE launching Zomboid."
echo "First launch: macOS Gatekeeper will block it — right-click -> Open -> confirm."
