{
  lib,
  opts,
  config,
  pkgs,
  ...
}: {
  ################
  # gpu specific #
  ################

  imports =
    lib.optionals (opts.gpu == "nvidia") [
      ./system-nvidia.nix
    ]
    ++ lib.optionals (opts.gpu == "amd") [
      ./system-amd.nix
    ];

  ###################
  # common settings #
  ###################

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

  services.printing.enable = true;

  programs.light.enable = true;

  # bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
