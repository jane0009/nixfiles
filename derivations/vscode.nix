{ pkgs, lib, ... }:

let
  inherit (pkgs) vscode-extensions vscode-utils vscode-with-extensions vscode-marketplace;
  exts = with vscode-marketplace; [
    arrterian.nix-env-selector
    github.copilot
    esbenp.prettier-vscode
    endormi."2077-theme"
    tanmay.slack-theme
    aaronduino.nix-lsp
    brettm12345.nixfmt-vscode
    ms-vscode.cpptools
    davidanson.vscode-markdownlint
    tamasfe.even-better-toml
    rust-lang.rust-analyzer
    panicbit.cargo
    jakebecker.elixir-ls
    ms-vscode.test-adapter-converter
    hbenl.vscode-test-explorer
    elmtooling.elm-ls-vscode
  ];
in vscode-with-extensions.override {
vscodeExtensions = with vscode-extensions;
    [
    bbenoist.nix
    dhall.dhall-lang
    ms-vscode-remote.remote-ssh
    ] ++ exts;
}
