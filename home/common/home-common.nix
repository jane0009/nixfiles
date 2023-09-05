{ lib, pkgs, specialArgs, inputs, ... }:

rec {
  # home-manager stuff
  home.username = specialArgs.name or "jane";
  home.homeDirectory = "/home/" + home.username;
  home.stateVersion = "23.05";
  programs.home-manager.enable = true;

  imports = [
    ./packages.nix
    ./things/git.nix
    ./things/ssh.nix
    (import ./things/shell.nix { inherit lib pkgs; })
    (import ./things/nvim.nix { inherit pkgs; })
  ] ++ lib.optionals (specialArgs.gui && specialArgs.dev) [ 
    (import ./things/vscode.nix { inherit pkgs specialArgs inputs; }) 
  ];
}
