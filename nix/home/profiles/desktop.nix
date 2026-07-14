{ pkgs, ... }:

{
  home.packages = with pkgs; [
    anki-bin
    btop
    cliphist
    dunst
    eza
    fuzzel
    fzf
    hyprpicker
    jq
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
        background = "181818f2";
        text = "d6d6d6ff";
        match = "8aadf4ff";
        selection = "2a2a2aff";
        selection-text = "ffffffff";
        border = "8aadf4ff";
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

  services.dunst = {
    enable = true;
    settings = {
      global = {
        corner_radius = 8;
        frame_width = 1;
        offset = "16x16";
        origin = "top-right";
        transparency = 8;
      };
    };
  };
}
