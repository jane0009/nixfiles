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
      "--login-server=[CENSORED]"
    ];
    package = pkgs.tailscale;
    openFirewall = true;
  };

  environment.systemPackages = [
    pkgs.tailscale
  ];
}
