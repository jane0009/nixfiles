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

  # opengl!!!!!!!!
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # fonts
  fonts.packages = with pkgs; [
    fira-code
    unifont
    font-awesome
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    corefonts
    courier-prime
    (nerdfonts.override {fonts = ["Inconsolata" "Iosevka"];})
  ];
  fonts.fontDir.enable = true;
  fonts.fontconfig.defaultFonts.monospace = ["Courier Prime" "Inconsolata"];

  # the usual suspects
  environment.systemPackages = with pkgs; [
    gcr
    pulseaudio
    alsa-utils
    blueberry # not every system will have bluetooth, but who cares
    feh
    ffmpeg
    ffmpegthumbnailer
    webp-pixbuf-loader
    gnome-epub-thumbnailer
    evince
    f3d
  ];
  programs.dconf.enable = true;

  # fm
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [thunar-archive-plugin thunar-volman];
  };
  services.tumbler.enable = true;
  services.gvfs.enable = true;

  # security
  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (subject.isInGroup("users")
        && (
          action.id == "org.freedesktop.login1.reboot" ||
          action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
          action.id == "org.freedesktop.login1.power-off" ||
          action.id == "org.freedesktop.login1.power-off-multiple-sessions"
        )) {
          return polkit.Result.YES;
        }
      })
    '';
  };

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

  # woo ! sound !
  sound.enable = true;
  # can't have PA with PW
  # hardware.pulseaudio.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # other stuff that requires a gui
  services.mullvad-vpn.enable = true;
  # THIS IS A H-M THING IM SO MAD
  # services.flameshot.enable = true;
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

  services.printing.enable = true;

  programs.light.enable = true;
}
