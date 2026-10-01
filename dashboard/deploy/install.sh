#!/usr/bin/env bash
# install.sh - deploy the zomboid-dashboard Flask app as a systemd service.
#
# Idempotent: safe to re-run. Replaces app files, rebuilds venv deps if
# requirements.txt changed, restarts the service.
#
# Usage:
#   bash install.sh                       # keep existing .env (or warn)
#   bash install.sh --mods-dir /path/..   # write .env with that MODS_DIR
#
# Must be run from inside the dashboard/ directory (sibling to deploy/).
# Needs sudo for the systemd bits.

set -euo pipefail

APP_DIR="$HOME/zomboid-dashboard"
MODS_DIR_ARG=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --mods-dir)
      shift
      MODS_DIR_ARG="${1:-}"
      [[ -n "$MODS_DIR_ARG" ]] || { echo "ERROR: --mods-dir needs a value" >&2; exit 1; }
      shift
      ;;
    -h|--help)
      sed -n '2,13p' "$0"
      exit 0
      ;;
    *)
      echo "ERROR: unknown arg: $1" >&2
      exit 1
      ;;
  esac
done

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_ROOT="$(cd "$HERE/.." && pwd)"

if [[ ! -f "$SRC_ROOT/app.py" ]]; then
  echo "ERROR: expected $SRC_ROOT/app.py - run this from the repo's dashboard/deploy dir" >&2
  exit 1
fi

echo "[install] app dir: $APP_DIR"
mkdir -p "$APP_DIR"

echo "[install] syncing dashboard files"
rsync -a --delete \
  --exclude='deploy/' \
  --exclude='venv/' \
  --exclude='.env' \
  --exclude='__pycache__/' \
  --exclude='*.pyc' \
  "$SRC_ROOT/" "$APP_DIR/"

if [[ ! -d "$APP_DIR/venv" ]]; then
  echo "[install] creating venv"
  python3 -m venv "$APP_DIR/venv"
fi

echo "[install] installing requirements"
"$APP_DIR/venv/bin/pip" install -q --upgrade pip
"$APP_DIR/venv/bin/pip" install -q -r "$APP_DIR/requirements.txt"

if [[ -n "$MODS_DIR_ARG" ]]; then
  echo "[install] writing .env (MODS_DIR=$MODS_DIR_ARG)"
  umask 077
  cat > "$APP_DIR/.env" <<EOF
MODS_DIR=$MODS_DIR_ARG
REPO=A-Su11y/zomboid-mods
EOF
  chmod 600 "$APP_DIR/.env"
elif [[ ! -f "$APP_DIR/.env" ]]; then
  echo "[install] WARNING: no .env present and --mods-dir not given."
  echo "[install]          create $APP_DIR/.env with MODS_DIR=... before first start."
fi

UNIT_SRC="$HERE/zomboid-dashboard.service"
UNIT_DST="/etc/systemd/system/zomboid-dashboard.service"
echo "[install] installing systemd unit at $UNIT_DST"
TMP_UNIT="$(mktemp)"
sed -e "s|__APP_DIR__|$APP_DIR|g" -e "s|__USER__|$USER|g" "$UNIT_SRC" > "$TMP_UNIT"
sudo install -m 644 "$TMP_UNIT" "$UNIT_DST"
rm -f "$TMP_UNIT"

sudo systemctl daemon-reload
sudo systemctl enable --now zomboid-dashboard
sudo systemctl restart zomboid-dashboard

sleep 2
if curl -sf http://localhost:8086/api/status >/dev/null; then
  echo "[install] OK"
else
  echo "[install] service not responding yet - check: sudo systemctl status zomboid-dashboard"
fi

HOST_IP="$(hostname -I 2>/dev/null | awk '{print $1}')"
[[ -z "$HOST_IP" ]] && HOST_IP="<host-ip>"
echo "[install] install complete, dashboard at http://$HOST_IP:8086"
