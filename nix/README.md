# sco's Nix Config

This directory is organized as a layered NixOS plus Home Manager flake.

## Layers

- `modules/core/base.nix`: shared base system settings for every machine.
- `modules/core/desktop-base.nix`: shared graphical desktop prerequisites.
- `modules/profiles/desktop.nix`: shared desktop package layer.
- `modules/services/*.nix`: reusable service chunks such as Tailscale and NAS mounts.
- `hosts/mini/default.nix`: machine-specific composition for this host.
- `hosts/mini/hardware-configuration.nix`: generated hardware configuration for this host.
- `hosts/mini/settings.nix`: host-specific user-facing settings, such as monitor layout.
- `home.nix`: shared user-level Home Manager config.
- `home/profiles/desktop.nix`: user-level terminal/editor/desktop foundation.
- `home/profiles/monitors.nix`: writes Hyprland monitor rules from host settings.

## Commands

Dry-check the flake:

```sh
nix flake check path:/home/sco/nix
```

Build the user Home Manager activation without switching:

```sh
home-manager build --flake path:/home/sco/nix#sco
```

Build the system without switching:

```sh
sudo nixos-rebuild build --flake path:/home/sco/nix#mini
```

Switch Home Manager:

```sh
home-manager switch --flake path:/home/sco/nix#sco
```

Switch the system:

```sh
sudo nixos-rebuild switch --flake path:/home/sco/nix#mini
```

## Notes

The current `/etc/nixos/configuration.nix` still includes a Frigate container with camera URLs and credentials inline. The layered flake does not include Frigate. If Frigate comes back later, migrate it deliberately with a secret-management approach instead of copying credentials into the repo.

The older `home-flake.nix` is still present, but `flake.nix` is now the standard entry point for the layered config.

After Home Manager is active, `nrs` runs the standard system switch for this machine.
