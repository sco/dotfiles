{ ... }:

{
  # Prefer Tailscale SSH over the public OpenSSH daemon.
  services.openssh.enable = false;
  services.tailscale = {
    enable = true;
    extraUpFlags = [ "--ssh" ];
  };
}
