{
  lib,
  pkgs,
  ...
}: {
  # nushell
  programs.starship = {
    enable = true;
    settings = {};
  };
  programs.zellij = {
    enable = true;
    settings = {};
  };
}
