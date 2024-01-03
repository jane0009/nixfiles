{
  lib,
  pkgs,
  specialArgs,
  inputs,
  ...
}: rec {
  imports = [
    ../common/home-common.nix
    ../common/dotcfg-common.nix
    ./dotcfg.nix
  ];
}
