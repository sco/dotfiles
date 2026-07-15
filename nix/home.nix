{ config, pkgs, ... }:

{
  imports = [
    ./home/profiles/monitors.nix
    ./home/profiles/desktop.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "sco";
  home.homeDirectory = "/home/sco";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # User packages
  home.packages = with pkgs; [
    libnotify  # notify-send

    # Claude Code wrapper
    (writeShellScriptBin "claude" ''
      if [[ $# -eq 0 ]]; then
        exec nix run github:sadjow/claude-code-nix#claude-code-bun -- -c
      else
        exec nix run github:sadjow/claude-code-nix#claude-code-bun "$@"
      fi
    '')

    (writeShellScriptBin "nrs" ''
      sudo nixos-rebuild switch --flake path:/home/sco/nix#mini "$@"
      rebuild_status=$?

      if [[ $rebuild_status -eq 0 ]] && command -v hyprctl >/dev/null 2>&1; then
        hyprctl reload >/dev/null 2>&1 || true
      fi

      exit "$rebuild_status"
    '')

    (writeShellScriptBin "browser" ''
      if command -v zen-browser >/dev/null 2>&1; then
        exec zen-browser "$@"
      fi

      exec firefox "$@"
    '')

    (writeShellScriptBin "hypr-send-shortcut-once" ''
      mods=''${1:?mods required}
      key=''${2:?key required}

      hyprctl dispatch sendshortcut "$mods, $key, activewindow"
    '')

    (writeShellScriptBin "clipboard-menu" ''
      selection="$(cliphist list | fuzzel --dmenu --prompt "Clipboard> ")" || exit 0
      [[ -n "$selection" ]] || exit 0
      printf '%s' "$selection" | cliphist decode | wl-copy
    '')

    (writeShellScriptBin "desktop-menu" ''
      choice="$(
        printf '%s\n' \
          "Clipboard history" \
          "Screenshot region" \
          "Color picker" \
          "Keybindings" \
          "Restart bar" \
          "Reload Hyprland" \
          "Rebuild NixOS" \
          "Lock" |
          fuzzel --dmenu --prompt "Desktop> "
      )" || exit 0

      case "$choice" in
        "Clipboard history") exec clipboard-menu ;;
        "Screenshot region") exec sh -c 'grim -g "$(slurp)" - | satty --filename -' ;;
        "Color picker") exec sh -c 'pkill hyprpicker || hyprpicker -a' ;;
        "Keybindings") exec notify-send "Hyprland Keys" "Super+Space: Launcher\nSuper+Alt+Space: Menu\nSuper+Enter: Terminal\nSuper+Shift+Enter: Browser\nSuper+C/V/X: Copy/Paste/Cut\nSuper+Ctrl+V: Clipboard history\nSuper+W: Close\nSuper+F: Fullscreen\nSuper+T: Float\nSuper+Shift+Arrow: Swap windows" ;;
        "Restart bar") exec sh -c 'pkill -f quickshell || true; qs --no-duplicate --daemonize' ;;
        "Reload Hyprland") exec hyprctl reload ;;
        "Rebuild NixOS") exec alacritty -e nrs ;;
        "Lock") exec hyprlock ;;
      esac
    '')

    (writeShellScriptBin "launcher-refresh" ''
      rm -f "$HOME/.cache/wofi-drun"
    '')
  ];

  # Notification daemon: mako is managed by the desktop Home Manager profile.

  # Ensure Home Manager packages are in PATH
  home.sessionPath = [
    "$HOME/.local/state/nix/profiles/home-manager/home-path/bin"
    "$HOME/.npm-global/bin"
  ];

  home.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      # Ensure Home Manager packages are in PATH (fallback if .profile didn't run)
      [[ -d "$HOME/.local/state/nix/profiles/home-manager/home-path/bin" ]] && \
        export PATH="$HOME/.local/state/nix/profiles/home-manager/home-path/bin:$PATH"

      # Source portable dotfiles config
      [[ -f ~/.shell.common ]] && source ~/.shell.common

      # Auto-attach to tmux for SSH sessions
      if [[ -n "$SSH_CONNECTION" && -z "$TMUX" ]] && command -v tmux &>/dev/null; then
        tmux attach-session -t main || tmux new-session -s main
      fi
    '';
  };

  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    historyLimit = 10000;
    escapeTime = 0;
    baseIndex = 1;
    extraConfig = ''
      set -g mouse on
      set -g status-style bg=default,fg=white
    '';
  };

  # Symlink main projects from ~/repos to workspace
  # Projects should live in ~/repos, workspace has symlinks
  home.file.".openclaw/workspace/medina".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/medina";
  home.file.".openclaw/workspace/dotfiles".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/dotfiles";
  home.file.".openclaw/workspace/yoga-practice-app".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/yoga-practice-app";
}
