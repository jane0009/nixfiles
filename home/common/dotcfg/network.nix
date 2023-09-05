{ lib, pkgs, ... }:
{
    home.file.".config/networkmanager-dmenu" = {
        source = ../../../cfg/networkmanager_dmenu;
        recursive = true;
    };
}