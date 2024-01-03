{
  lib,
  pkgs,
  ...
}: {
  home.file.".config/i3" = {
    source = ../../../cfg/i3;
    recursive = true;
  };
  home.file.".config/alacritty" = {
    source = ../../../cfg/alacritty;
    recursive = true;
  };
  home.file.".config/i3blocks" = {
    source = ../../../cfg/i3blocks;
    recursive = true;
  };
}
