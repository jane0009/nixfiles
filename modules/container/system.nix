{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = ["${nixpkgs}/nixos/modules/virtualisation/lxc-container.nix"];
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
