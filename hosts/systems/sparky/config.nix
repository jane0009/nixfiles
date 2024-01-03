{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  monit-cfg = import ./monitors.nix;
  monitors = attrsets.mapAttrs (_: head) (lists.groupBy (x: x.name) monit-cfg.monitors);
  monit-map = config: {
    enable = config.enable;
    primary = config.primary;
    position = config.position;
    mode = config.resolution;
    rate = config.rate;
    rotate = config.rotate;
    crtc = config.crtc;
    dpi = config.dpi;
    scale = config.scale;
  };
in {
  imports = [
    ../../inherits/base.nix
    ../../inherits/gui-amd.nix
    ../../inherits/emulation.nix
    ../../inherits/development.nix
    ../../inherits/ssd.nix
  ];
  # the  most important stuff first
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "23.05";

  # home manager stuff
  home-manager.extraSpecialArgs = {
    dev = true;
    gui = true;
    personal = true;
    emu = true;
  };
  home-manager.users.jane = ../../../home/sparky/home.nix;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.thermald.enable = true;

  services.autorandr = {
    enable = true;
    defaultTarget = "normal";
    profiles = {
      "normal" = {
        fingerprint = attrsets.mapAttrs (name: value: value.fingerprint) monitors;
        config = attrsets.mapAttrs (name: value: monit-map value) monitors;
      };
    };
  };

  systemd.services.autorandr = {
    wantedBy = ["graphical.target"];
    after = ["graphical.target"];
  };

  # i fucking hate windows
  time.hardwareClockInLocalTime = true;

  time.timeZone = "America/New_York";

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  services.xrdp = {
    enable = true;
    defaultWindowManager = "i3";
    openFirewall = true;
  };

  services.xserver.libinput.enable = true;
  services.gnome.gnome-keyring.enable = true;
}
