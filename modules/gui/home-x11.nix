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

  home.packages = with pkgs; [
    i3
    xorg.xev
    xscreensaver
    xsecurelock
    xss-lock
    font-awesome
    fontconfig
    lxappearance
    feh
    libnotify
    flameshot
    xclip
  ];
}
