{
  config,
  pkgs,
  lib,
  ...
}: {
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [80 443 5900];
    allowedUDPPortRanges = [
      {
        from = 4000;
        to = 4007;
      }
      {
        from = 5900;
        to = 5900;
      }
      {
        from = 8000;
        to = 8010;
      }
    ];
  };
}
