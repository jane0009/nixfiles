{
  lib,
  pkgs,
  specialArgs,
  ...
}: rec {
  imports = [
    ../common/home-common.nix
    ../common/dotcfg-common.nix
    ../common/things/hyprland-config.nix
    ./dotcfg.nix
  ];
}
