{ pkgs, ... }:

{
  home.packages = with pkgs; [
    anki-bin
    btop
    dunst
    eza
    fzf
    hyprpicker
    jq
    quickshell
    starship
    tldr
    awww
    wl-clipboard
    wofi
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
