{
  lib,
  config,
  pkgs,
  ...
}: {
  # hostname rationale: headscale + nixos -> "hixos" -> hicks -> hillbilly
  imports = [
    ../../inherits/base.nix
    ../../inherits/firewall.nix
    ../../inherits/server.nix
    ./headscale.nix
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

  networking = {
    nameservers = ["1.1.1.1" "192.168.1.1"];
    interfaces = {
      "eth0" = {
        useDHCP = false;
        ipv4.addresses = [
          {
            address = "192.168.1.200";
            prefixLength = 24;
          }
        ];
      };
    };
    defaultGateway = {
      address = "192.168.1.1";
      interface = "eth0";
    };
  };
}
