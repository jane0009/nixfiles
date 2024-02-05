{
  lib,
  config,
  pkgs,
  ...
}: {
  # enable gui
  services.xserver = {
    enable = true;
    layout = "us";
    desktopManager = {
      xterm.enable = true;
      xfce = {
        enable = false;
        noDesktop = true;
        enableXfwm = false;
      };
    };
    displayManager = {
      defaultSession = "none+i3";
    };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [rofi i3blocks i3status i3lock];
    };
  };

  # polkit
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-auth";
    wantedBy = ["graphical-session.target"];
    wants = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # the usual suspects
  environment.systemPackages = with pkgs; [
    pulseaudio
    pavucontrol
    alsa-utils
    feh
    alacritty
  ];
}
