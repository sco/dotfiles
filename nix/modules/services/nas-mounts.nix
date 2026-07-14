{ ... }:

{
  fileSystems."/mnt/share" = {
    device = "//192.168.0.8/sco";
    fsType = "cifs";
    options =
      let
        automountOpts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in
      [
        "${automountOpts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=100,file_mode=0664,dir_mode=0775"
      ];
  };

}
