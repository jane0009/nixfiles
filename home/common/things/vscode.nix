{
  pkgs,
  specialArgs,
  inputs,
  ...
}: {
  programs.vscode = {
    enable = specialArgs.gui;
    package = pkgs.callPackage ../../../derivations/vscode.nix {inputs = inputs;};
  };
}
