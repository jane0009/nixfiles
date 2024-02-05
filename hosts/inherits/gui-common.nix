{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./fonts.nix
  ];

  # opengl!!!!!!!!
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # we always need you, dconf
  programs.dconf.enable = true;

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

  # fm
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [thunar-archive-plugin thunar-volman];
  };
  services.tumbler.enable = true;
  services.gvfs.enable = true;

  environment.systemPackages = with pkgs; [
    gcr
    blueman # not every system will have bluetooth, but who cares
    ffmpeg
    ffmpegthumbnailer
    webp-pixbuf-loader
    gnome-epub-thumbnailer
    evince
    f3d
  ];

  # bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
