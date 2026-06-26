#!/usr/bin/env bash
set -euo pipefail

echo "==> Removing unwanted Omarchy defaults..."
sudo pacman -Rns --noconfirm libreoffice-fresh typora xournalpp 2>/dev/null || true

echo "==> Installing additional packages..."
yay -S --noconfirm \
  avahi \
  bun \
  garage \
  libsecret \
  linux-zen \
  linux-zen-headers \
  minibook-support-git \
  tailscale \
  wtype \
  zen-browser-bin
