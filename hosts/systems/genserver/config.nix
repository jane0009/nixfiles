{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../inherits/base.nix
    ../../inherits/server.nix
  ];

  systemd.suppressedSystemUnits = [
    "dev-mqueue.mount"
    "sys-kernel-debug.mount"
    "sys-fs-fuse-connections.mount"
  ];

  system.stateVersion = "23.05";

  home-manager.extraSpecialArgs = {
    server = true;
  };
  home-manager.users.jane = ../../../home/generic/home.nix;
}
