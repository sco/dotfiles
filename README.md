# dotfiles

Personal config for an [Omarchy](https://omarchy.org) machine.

## Setup

```bash
bash omarchy/install.sh
```

This will:
- Symlink `.shell.common` and `.gitconfig` into `$HOME`
- Remove unwanted Omarchy defaults (libreoffice, typora, xournalpp)
- Install additional packages (tailscale, zen-browser, linux-zen, etc.)
- Install custom webapps (Medina Shelley, Tailscale, gmail)
- Copy `omarchy/hypr/bindings.conf` to `~/.config/hypr/`

## Keybindings

Custom additions on top of Omarchy defaults live in `omarchy/hypr/bindings.conf`.
Notable custom binding: `Alt+Space` → ostt (speech-to-text paste).

Running `omarchy refresh hyprland` will overwrite the live bindings.conf — re-run
`bash omarchy/install.sh` (or just the final `cp` line) to restore it.

## Other directories

- `bin/` — personal scripts
- `nix/` — Home Manager config (NixOS machines)
