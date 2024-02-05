{
  config,
  lib,
  pkgs,
  opts,
  inputs,
  ...
}: {
  environment.systemPackages = [
    pkgs.pkg-config
  ];
  imports =
    lib.optionals (opts.code-server == true) [
      inputs.vscode-server.nixosModules.default
    ]
    ++ lib.optionals (opts.wsl == true) [
      inputs.nixos-wsl.nixosModules.wsl
    ];
}
