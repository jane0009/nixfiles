{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  services.xrdp = {
    enable = true;
    openFirewall = true;
  };

  services.x2goserver.enable = true;
}
