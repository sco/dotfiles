#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")/.." && pwd)"
OMARCHY="$DOTFILES/omarchy"

echo "==> Symlinking shell and git config..."
ln -sf "$DOTFILES/.shell.common" "$HOME/.shell.common"
ln -sf "$DOTFILES/.gitconfig" "$HOME/.gitconfig"

echo "==> Installing/removing packages..."
bash "$OMARCHY/packages.sh"

echo "==> Setting up custom webapps..."
bash "$OMARCHY/webapps.sh"

echo "==> Copying Hyprland bindings..."
cp "$OMARCHY/hypr/bindings.conf" "$HOME/.config/hypr/bindings.conf"

echo "Done!"
