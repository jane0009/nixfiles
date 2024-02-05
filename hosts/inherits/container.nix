{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./fonts.nix
  ];
  systemd.services."getty@tty1" = {
    enable = lib.mkForce true;
    wantedBy = ["getty.target"];
    serviceConfig.Restart = "always";
  };

  environment.systemPackages = with pkgs; [
    vim
    binutils
  ];
}
