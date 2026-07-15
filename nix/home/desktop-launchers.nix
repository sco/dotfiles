{ pkgs, ... }:

{
  home.packages = with pkgs; [
    libnotify

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

    (writeShellScriptBin "app-menu" ''
      choice="$(
        printf '%s\n' \
          "Neovim" \
          "X" \
          "GitHub" \
          "Gmail" \
          "Google Calendar" \
          "Medina" \
          "YouTube Music" \
          "1Password" |
          fuzzel --dmenu --prompt "Open> "
      )" || exit 0

      case "$choice" in
        "Neovim") exec alacritty -e nvim ;;
        "X") exec browser --new-window https://x.com ;;
        "GitHub") exec browser --new-window https://github.com ;;
        "Gmail") exec browser --new-window https://mail.google.com ;;
        "Google Calendar") exec browser --new-window https://calendar.google.com ;;
        "Medina")
          set -a
          [[ -f "$HOME/.config/medina/.env" ]] && . "$HOME/.config/medina/.env"
          set +a
          exec browser --new-window "''${MEDINA_ENDPOINT:-''${MEDINA_ROOT:-http://localhost:3002}}"
          ;;
        "YouTube Music") exec pear-desktop ;;
        "1Password") exec 1password ;;
      esac
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
      rm -rf "$HOME/.cache/fuzzel" "$HOME/.cache/wofi-drun"
    '')
  ];

  xdg.enable = true;

  home.file = {
    ".local/share/applications/nvim.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Neovim
      GenericName=Text Editor
      Comment=Edit text files
      Exec=alacritty -e nvim %F
      Icon=nvim
      Terminal=false
      Categories=Utility;TextEditor;Development;
      MimeType=text/plain;text/x-makefile;text/x-c++;text/x-c;text/x-shellscript;application/x-shellscript;
    '';

    ".local/share/applications/com.github.th_ch.youtube_music.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=YouTube Music
      Exec=pear-desktop %u
      Icon=pear-desktop
      StartupWMClass=com.github.th_ch.youtube_music
      Categories=AudioVideo;Audio;Player;
    '';

    ".local/share/applications/x.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=X
      Exec=browser --new-window https://x.com
      Icon=browser
      Terminal=false
      Categories=Network;
    '';

    ".local/share/applications/github.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=GitHub
      Exec=browser --new-window https://github.com
      Icon=browser
      Terminal=false
      Categories=Development;Network;
    '';

    ".local/share/applications/gmail.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Gmail
      Exec=browser --new-window https://mail.google.com
      Icon=browser
      Terminal=false
      Categories=Network;Email;
    '';

    ".local/share/applications/google-calendar.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Google Calendar
      Exec=browser --new-window https://calendar.google.com
      Icon=browser
      Terminal=false
      Categories=Office;Calendar;Network;
    '';

    ".local/share/applications/medina.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Medina
      Exec=sh -lc 'set -a; [ -f "$HOME/.config/medina/.env" ] && . "$HOME/.config/medina/.env"; set +a; browser --new-window "''${MEDINA_ENDPOINT:-''${MEDINA_ROOT:-http://localhost:3002}}"'
      Icon=browser
      Terminal=false
      Categories=Network;Audio;
    '';

    ".local/share/applications/Alacritty.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Hidden=true
    '';
    ".local/share/applications/anki.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Hidden=true
    '';
    ".local/share/applications/btop.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Hidden=true
    '';
    ".local/share/applications/com.google.Chrome.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Hidden=true
    '';
    ".local/share/applications/cups.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Hidden=true
    '';
    ".local/share/applications/firefox.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Hidden=true
    '';
    ".local/share/applications/google-chrome.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Hidden=true
    '';
    ".local/share/applications/gvim.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Hidden=true
    '';
    ".local/share/applications/nixos-manual.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Hidden=true
    '';
    ".local/share/applications/org.freedesktop.Xwayland.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Hidden=true
    '';
    ".local/share/applications/org.quickshell.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Hidden=true
    '';
    ".local/share/applications/satty.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Hidden=true
    '';
    ".local/share/applications/vim.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Hidden=true
    '';
    ".local/share/applications/xdg-desktop-portal-gtk.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Hidden=true
    '';
    ".local/share/applications/xterm.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Hidden=true
    '';
  };
}
