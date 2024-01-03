{
  config,
  pkgs,
  lib,
  ...
}: {
  # enable docs?
  documentation = {
    enable = lib.mkForce false;
    nixos = {
      enable = lib.mkForce false;
      options.warningsAreErrors = false;
    };
    man.enable = lib.mkForce false;
    info.enable = lib.mkForce false;
    dev.enable = lib.mkForce false;
  };
}
