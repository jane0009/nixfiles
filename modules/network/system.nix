{
  lib,
  opts,
  config,
  pkgs,
  ...
}: let
  getNetworkSettings = import ./get-network-settings.nix {inherit config lib;};
in {
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [80 443];
    allowedUDPPortRanges = [
      # what do these do? do i need them?
      {
        from = 4000;
        to = 4007;
      }
      {
        from = 8000;
        to = 8010;
      }
    ];
  };

  networking.networkmanager.ensureProfiles = getNetworkSettings opts.network;
}
