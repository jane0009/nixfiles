{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  services.tailscale = {
    enable = true;
    extraUpFlags = [
      "--login-server=https://hs.j4.pm"
    ];
    package = pkgs.tailscale;
    openFirewall = true;
  };

  environment.systemPackages = [
    pkgs.tailscale
  ];
}
