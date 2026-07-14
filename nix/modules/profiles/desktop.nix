{ pkgs, ... }:

{
  # Shared desktop package layer. Keep personal state, themes, keybindings,
  # and wallpapers in Home Manager or a separate dotfiles repo.
  environment.systemPackages = with pkgs; [
    brightnessctl
    dunst
    grim
    hypridle
    hyprlock
    hyprpaper
    pamixer
    playerctl
    satty
    slurp
    awww
    wl-clipboard
    wlogout
    wofi
    pear-desktop
  ];
}
