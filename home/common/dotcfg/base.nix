{
  lib,
  pkgs,
  ...
}: {
  home.file.".config/nushell" = {
    source = ../../../cfg/nushell;
    recursive = true;
  };
  home.file.".config/neofetch" = {
    source = ../../../cfg/neofetch;
    recursive = true;
  };
  home.file.".config/nvim" = {
    source = ../../../cfg/nvim;
    recursive = true;
  };
  home.file.".config/starship" = {
    source = ../../../cfg/starship;
    recursive = true;
  };
}
