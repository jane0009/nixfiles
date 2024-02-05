{
  lib,
  opts,
  ...
}: {
  imports =
    lib.optionals (opts.wm == "wayland") [
      ./home-wayland.nix
    ]
    ++ lib.optionals (opts.wm == "x11") [
      ./home-x11.nix
    ];

  home.file.".config/hh3/discordcanary.json" = {
    source = ../../../cfg/hh3/discordcanary.json;
  };
  home.file.".config/hh3/compiled-sass.css" = {
    source = ../../../cfg/hh3/sass/compiled.css;
  };

  home.packages = [
    fontconfig
    syncthing
    syncthingtray
    networkmanagerapplet
    networkmanager_dmenu
    firefox
    sonixd
    nicotine-plus
    # TODO auto inject hh3 and/or moonlight
    discord-canary
    (import ../../derivations/hh3/sass.nix {
      inherit lib pkgs;
    })
    gajim
    qimgv
    mullvad-vpn
    quasselClient
    obsidian
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    thunderbird
    krita
  ];
}
