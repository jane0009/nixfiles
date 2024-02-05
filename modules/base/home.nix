{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./git.nix
    ./ssh.nix
    ./shell.nix
    ./nvim.nix
  ];

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

  home.packages = [
    croc
    wget
    curl
    xsel
    neofetch
    htop
    jq
    ripgrep
    nix-index
    dig
    whois
    #niv
    bat
    du-dust
    gnupg
    libsecret
    pinentry
    colmena
    rnix-lsp # move to dev
  ];
}
