{ lib, pkgs, ... }:
{
    home.file.".config/Code/User" = {
        source = ../../../cfg/Code/User;
        recursive = true;
    };
}