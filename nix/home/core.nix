{ config, pkgs, username ? "sco", ... }:

let
  homeDirectory =
    if username == "root" then
      "/root"
    else
      "/home/${username}";
in
{
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    bat
    eza
    fd
    fzf
    jq
    ripgrep
    starship
    tldr
    zoxide
  ];

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
      [[ -d "$HOME/.local/state/nix/profiles/home-manager/home-path/bin" ]] && \
        export PATH="$HOME/.local/state/nix/profiles/home-manager/home-path/bin:$PATH"

      [[ -f ~/.shell.common ]] && source ~/.shell.common

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

  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
