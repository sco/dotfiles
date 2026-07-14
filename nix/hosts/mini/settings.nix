{
  # Hyprland monitor rules. Format:
  # monitor = name,resolution,position,scale[,transform]
  #
  # Transform values: 0 normal, 1 90deg, 2 180deg, 3 270deg.
  # This generic rule applies to the current/default monitor. Replace the
  # leading comma with a connector name from `hyprctl monitors` if needed.
  hyprlandMonitors = [
    ",preferred,auto,1.5,transform,1"
  ];
}
