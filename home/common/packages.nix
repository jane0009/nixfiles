{
  lib,
  config,
  specialArgs,
  pkgs,
  ...
}: let
  packages = with pkgs; rec {
    base = [
      croc
      wget
      curl
      nushell
      #git
      xsel
      #busybox
      neofetch
      htop
      jq
      ripgrep
      nix-index
      dig
      whois
      fortune
      niv
      bat
      du-dust
      # security ??
      gnupg
      libsecret
      pinentry

      colmena
      nixfmt
      rnix-lsp
    ];
    gui = [
      # wm stuff
      i3
      xorg.xev
      xscreensaver
      xsecurelock
      xss-lock
      font-awesome
      fontconfig
      lxappearance
      syncthing
      syncthingtray
      feh
      libnotify
      #dunst
      networkmanagerapplet
      networkmanager_dmenu

      # default gui apps
      # alacritty
      firefox
      flameshot
      sonixd
      nicotine-plus
      discord-canary
      (import ../../derivations/hh3/sass.nix {
        inherit lib;
        inherit pkgs;
      })
      gajim
      qimgv
      xclip
      mullvad-vpn
      quasselClient
      obsidian
      libreoffice-qt
      hunspell
      hunspellDicts.en_US
      thunderbird
      krita
    ];

    guiDev = [
      jetbrains.idea-ultimate
    ];

    development = [
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
    ];

    games = [prismlauncher steam];

    server = [];

    emulation = [
      qemu_full
      libvirt
      virt-manager
    ];
    fun = [
      hollywood
    ];

    selectedPackages =
      base
      ++ (
        if specialArgs.dev
        then development
        else []
      )
      ++ (
        if specialArgs.gui
        then gui
        else []
      )
      ++ (
        if specialArgs.server
        then server
        else []
      )
      ++ (
        if specialArgs.emu
        then emulation
        else []
      )
      ++ (
        if specialArgs.personal
        then games
        else []
      )
      ++ (
        if specialArgs.gui && specialArgs.dev
        then guiDev
        else []
      )
      ++ (
        if specialArgs.random
        then fun
        else []
      );
  };
in {
  home.packages = packages.selectedPackages;
}
