{ hostname ? "mini", pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellScriptBin "nrs" ''
      sudo nixos-rebuild switch --flake path:/home/sco/nix#${hostname} "$@"
      rebuild_status=$?

      if [[ $rebuild_status -eq 0 ]] && command -v hyprctl >/dev/null 2>&1; then
        hyprctl reload >/dev/null 2>&1 || true
      fi

      exit "$rebuild_status"
    '')
  ];
}
