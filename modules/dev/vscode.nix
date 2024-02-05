{
  pkgs,
  specialArgs,
  inputs,
  ...
}: {
  programs.vscode = {
    enable = specialArgs.gui;
    package = pkgs.callPackage ../../derivations/vscode.nix {inputs = inputs;};
  };
  home.file.".config/Code/User" = {
    source = ../../../cfg/Code/User;
    recursive = true;
  };
}
