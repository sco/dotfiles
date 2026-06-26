#!/usr/bin/env bash
set -euo pipefail

ICONS_SRC="$(cd "$(dirname "$0")/webapps/icons" && pwd)"
ICONS_DEST="$HOME/.local/share/applications/icons"

echo "==> Installing custom webapp icons..."
mkdir -p "$ICONS_DEST"
cp "$ICONS_SRC"/* "$ICONS_DEST/"

echo "==> Installing custom webapps..."
omarchy webapp install "Medina Shelley" "https://medina.shelley.exe.xyz/new" "Medina Shelley.png"
omarchy webapp install "Tailscale" "https://login.tailscale.com/admin/machines" "Tailscale.png"
omarchy webapp install "gmail" "https://gmail.google.com/" "gmail.png"
