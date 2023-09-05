{ lib, pkgs, config, modulesPath, ... }:

with lib; {
  imports = [ 
    "${modulesPath}/profiles/minimal.nix"
    ../inherits/base.nix
    ../inherits/development.nix
   ];

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    defaultUser = "jane";
    startMenuLaunchers = true;
    nativeSystemd = true;
  };

  # pkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "22.05";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    server = true;
    dev = true;
  };
  home-manager.users.jane = ../../home/generic/home.nix;

  networking.hostName = "J3B3GX9";
  services.vscode-server.enable = true;

  programs.dconf.enable = true;
}
