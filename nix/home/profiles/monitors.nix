{ hostSettings ? { }, lib, ... }:

let
  monitors = hostSettings.hyprlandMonitors or [
    ",preferred,auto,1"
  ];
in
{
  home.file.".config/hypr/monitors.conf".text =
    lib.concatMapStringsSep "\n" (monitor: "monitor=${monitor}") monitors
    + "\n";
}
