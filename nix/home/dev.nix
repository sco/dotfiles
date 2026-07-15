{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bun
    curl
    git
    gh
    nodejs

    (writeShellScriptBin "claude" ''
      if [[ $# -eq 0 ]]; then
        exec nix run github:sadjow/claude-code-nix#claude-code-bun -- -c
      else
        exec nix run github:sadjow/claude-code-nix#claude-code-bun "$@"
      fi
    '')
  ];
}
