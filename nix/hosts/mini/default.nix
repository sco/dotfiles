{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core/base.nix
    ../../modules/core/desktop-base.nix
    ../../modules/profiles/desktop.nix
    ../../modules/services/tailscale.nix
    ../../modules/services/nas-mounts.nix
  ];

  networking.hostName = "mini";

  boot.initrd.luks.devices."luks-95dc154d-a51d-4265-962c-8abe5f563e56".device =
    "/dev/disk/by-uuid/95dc154d-a51d-4265-962c-8abe5f563e56";

  # Keep this pinned to the NixOS release used for the first install.
  system.stateVersion = "25.11";
}
