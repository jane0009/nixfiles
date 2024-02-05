{
  config,
  lib,
  pkgs,
  opts,
  inputs,
  ...
}: {
  imports = lib.optionals (builtins.hasAttr opts "wm") [
    ./vscode.nix
  ];
  home.packages = with pkgs;
    [
      fnm
      fenix.default.toolchain
      fenix.rust-analyzer
      temurin-bin-18
      gradle
      zigpkgs.default
      sccache
      mprocs
      gitui
      bacon
      cargo-info
      rtx
      (pkgs.callPackage ../../derivations/zigmod.nix {})
    ]
    ++ lib.optionals (builtins.hasAttr opts "wm") [
      pkgs.jetbrains.idea-ultimate
    ];
}
