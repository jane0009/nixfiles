{ lib, pkgs, ... }:
{
    home.file.".config/hh3/discordcanary.json" = {
        source = ../../../cfg/hh3/discordcanary.json;
    };
    home.file.".config/hh3/compiled-sass.css" = {
        source = ../../../cfg/hh3/sass/compiled.css;
    };
}