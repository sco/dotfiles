{ pkgs, ... }:

let
  theme = {
    background = "#1a1b26";
    foreground = "#a9b1d6";
    accent = "#7aa2f7";
    selectionBackground = "#32344a";
    muted = "#444b6a";
    warning = "#e0af68";
    urgent = "#f7768e";
  };
  fuzzelColor = hex: alpha: builtins.substring 1 6 hex + alpha;
in

{
  home.packages = with pkgs; [
    anki-bin
    btop
    cliphist
    eza
    fuzzel
    fzf
    hyprpicker
    jq
    mako
    quickshell
    starship
    tldr
    awww
    wl-clipboard
    zoxide
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      window.padding = {
        x = 8;
        y = 8;
      };
      font.size = 11;
      colors = {
        primary = {
          background = "0x1a1b26";
          foreground = "0xa9b1d6";
        };
        cursor = {
          text = "0x1a1b26";
          cursor = "0xc0caf5";
        };
        selection = {
          text = "0xc0caf5";
          background = "0x32344a";
        };
        normal = {
          black = "0x32344a";
          red = "0xf7768e";
          green = "0x9ece6a";
          yellow = "0xe0af68";
          blue = "0x7aa2f7";
          magenta = "0xad8ee6";
          cyan = "0x449dab";
          white = "0x787c99";
        };
        bright = {
          black = "0x444b6a";
          red = "0xff7a93";
          green = "0xb9f27c";
          yellow = "0xff9e64";
          blue = "0x7da6ff";
          magenta = "0xbb9af7";
          cyan = "0x0db9d7";
          white = "0xacb0d0";
        };
      };
      keyboard.bindings = [
        {
          key = "Insert";
          mods = "Control";
          action = "Copy";
        }
        {
          key = "Insert";
          mods = "Shift";
          action = "Paste";
        }
      ];
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = false;
    withRuby = false;
    extraPackages = with pkgs; [
      ripgrep
      fd
      tree-sitter
    ];
  };

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "alacritty -e";
        layer = "overlay";
        width = 48;
        lines = 12;
        tabs = 4;
      };
      colors = {
        background = fuzzelColor theme.background "f2";
        text = fuzzelColor theme.foreground "ff";
        match = fuzzelColor theme.accent "ff";
        selection = fuzzelColor theme.selectionBackground "ff";
        selection-text = "ffffffff";
        border = fuzzelColor theme.accent "ff";
      };
      border = {
        width = 1;
        radius = 8;
      };
    };
  };

  systemd.user.services.cliphist-text = {
    Unit = {
      Description = "Clipboard history for text";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  systemd.user.services.cliphist-image = {
    Unit = {
      Description = "Clipboard history for images";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  services.mako = {
    enable = true;
    settings = {
      anchor = "top-right";
      background-color = theme.background;
      border-color = theme.accent;
      border-radius = 8;
      border-size = 2;
      default-timeout = 5000;
      font = "sans-serif 14";
      height = 120;
      max-icon-size = 32;
      outer-margin = 20;
      padding = "10,15";
      text-color = theme.foreground;
      width = 420;

      "mode=do-not-disturb" = {
        invisible = true;
      };

      "mode=do-not-disturb app-name=notify-send" = {
        invisible = false;
      };

      "urgency=critical" = {
        border-color = theme.urgent;
        default-timeout = 0;
        layer = "overlay";
      };
    };
  };
}
