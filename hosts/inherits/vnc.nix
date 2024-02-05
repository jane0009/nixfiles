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
}
