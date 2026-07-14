# dotfiles

Personal config for `sco` machines.

## Current NixOS Setup

This machine is `mini`.

The active NixOS/Home Manager config lives in:

```sh
~/nix
```

Use this to apply changes:

```sh
nrs
```

`nrs` is a Home Manager helper for:

```sh
sudo nixos-rebuild switch --flake path:/home/sco/nix#mini
```

`/etc/nixos` is old/bootstrap config, not the source of truth.

## Layout

- `nix/` - NixOS and Home Manager config
- `.config/hypr/` - Hyprland config and local keybindings
- `.config/quickshell/` - Quickshell config
- `bin/` - personal scripts
- `.shell.common` - portable shell additions sourced by Home Manager

## Omarchy

Older Omarchy setup notes and files may still exist in this repo. They are now reference material, not the active source of truth for `mini`.
