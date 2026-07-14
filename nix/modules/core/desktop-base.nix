{ pkgs, ... }:

{
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.firefox.enable = true;
  programs._1password.enable = true;
  programs._1password-gui.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.power-profiles-daemon.enable = true;

  environment.systemPackages = with pkgs; [
    google-chrome
    alacritty
    gnome-keyring
    libsecret
    neovim
    polkit_gnome
    wayland
    xwayland
  ];
}
