{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    wayvnc
    openssl
  ];
  networking.firewall.allowedTCPPorts = [5900];
  networking.firewall.allowedUDPPortRanges = [
    {
      from = 5900;
      to = 5900;
    }
  ];
}
