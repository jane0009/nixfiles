{
  lib,
  pkgs,
  specialArgs,
  ...
}: {
  imports =
    [
      ./dotcfg/base.nix
    ]
    ++ lib.optionals (specialArgs.gui) [
      ./dotcfg/gui.nix
    ]
    ++ lib.optionals (specialArgs.personal) [
      ./dotcfg/communication.nix
    ]
    ++ lib.optionals (specialArgs.wifi) [
      ./dotcfg/network.nix
    ]
    ++ lib.optionals (specialArgs.gui && specialArgs.dev) [
      ./dotcfg/vscode.nix
    ];
}
