{
  config,
  pkgs,
  lib,
  ...
}: {
  # enable docs?
  documentation = {
    enable = lib.mkForce true;
    nixos = {
      enable = lib.mkForce true;
      options.warningsAreErrors = lib.mkForce false;
    };
    man.enable = lib.mkForce true;
    info.enable = lib.mkForce true;
    dev.enable = lib.mkForce true;
  };
}
