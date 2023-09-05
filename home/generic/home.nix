{ lib, pkgs, specialArgs, inputs, ... }:
let
  common = import ../common/home-common.nix {
    inherit lib pkgs specialArgs inputs;
  };
in
rec {
    imports = [
        ../common/dotcfg-common.nix
    ];
} // common