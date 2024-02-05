{
  lib,
  pkgs,
  ...
}: {
  # don't take the entire folder, h-m deals with the hyprland.conf file
  home.file.".config/hypr/plugins.conf" = {
    source = ../../../cfg/hypr/plugins.conf;
  };
  home.file.".config/hypr/swaylock.png" = {
    source = ../../../cfg/hypr/swaylock.png;
  };
  home.file.".config/wpaperd" = {
    source = ../../../cfg/wpaperd;
    recursive = true;
  };
  home.file.".config/swaync" = {
    source = ../../../cfg/swaync;
    recursive = true;
  };
  home.file.".config/ironbar" = {
    source = ../../../cfg/ironbar;
    recursive = true;
    executable = true;
  };
  home.file.".config/wlogout" = {
    source = ../../../cfg/wlogout;
    recursive = true;
  };
}
