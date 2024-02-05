{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  # it's that shrimple
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
  # ozone hint for electron
  #environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    # basics
    libsForQt5.qt5.qtwayland
    libsForQt5.qt5ct
    qt6.qtwayland
    qt6Packages.qt6ct
    polkit-kde-agent
    libva
    libva-utils
    libdrm
    meson
    wlroots
    wayland-protocols
    wayland-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    hyprnome
    kanshi #autorandr 2
    #waybar
    ironbar
    swaynotificationcenter
    swayosd
    wlogout
    swayidle
    swaylock-effects
    wl-clipboard
    cliphist
    # terminal
    kitty
    #wofi
    rofi-wayland
    # see: anyrun in home-manager
    # touch gesture support
    glm
    # wallpapers
    # hyprpaper
    wpaperd
    # screenshots
    grim
    slurp
    swappy
    wf-recorder
    # color picker
    hyprpicker
    # for greetd
    greetd.tuigreet
    # misc
    # hyprdim
    wluma
    playerctl
    cava
    # just good to have
    # wshowkeys # not necessary, xev
    ffmpeg
  ];

  # xdg portal
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  # dbus for swayosd

  # greeter
  services.xserver.enable = true;
  services.xserver.displayManager = {
    defaultSession = "hyprland";
    #lightdm = {
    #  enable = false;
    #  background = ../../images/greeter-bg.png;
    #  greeters.slick = {
    #    enable = true;
    #  };
    #  # maybe more
    #};
    sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  systemd.user.services.polkit-kde-authentication-agent-1 = {
    description = "polkit-kde-auth";
    wantedBy = ["graphical-session.target"];
    wants = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
