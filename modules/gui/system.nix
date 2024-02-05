{
  lib,
  opts,
  ...
}: {
  imports =
    lib.optionals (opts.wm == "wayland") [
      ./system-wayland.nix
    ]
    ++ lib.optionals (opts.wm == "x11") [
      ./system-x11.nix
    ];

  # fm
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [thunar-archive-plugin thunar-volman];
  };
  services.tumbler.enable = true;
  services.gvfs.enable = true;

  environment.systemPackages = with pkgs; [
    gcr
    ffmpeg
    ffmpegthumbnailer
    webp-pixbuf-loader
    gnome-epub-thumbnailer
    evince
    f3d
  ];

  services.mullvad-vpn.enable = true;

  services.syncthing = {
    enable = true;
    user = "jane";
    dataDir = "/home/jane/Documents";
    configDir = "/home/jane/.config/syncthing";
    settings.gui = {
      user = "jane";
      password = "AAAA1313v56"; # dummy password until i can agenix things
    };
    openDefaultPorts = true;
  };
}
