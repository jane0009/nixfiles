{
  lib,
  pkgs,
  specialArgs,
  ...
}: {
  # dotcfg-common should be imported in the home file itself
  # this is for config specific things
  imports = [
    ../common/dotcfg/hyprland.nix
  ];
  home.file.".config/kanshi/config" = {
    source = ../../cfg/kanshi/shimmy;
  };
}
