{
  lib,
  config,
  pkgs,
  ...
}: let
  rogauracore = pkgs.callPackage ../../../derivations/rogauracore.nix {};
in {
  imports = [
    ../../inherits/base.nix
    ../../inherits/gui-nvidia.nix
    ../../inherits/emulation.nix
    ../../inherits/development.nix
    ../../inherits/ssd.nix
    ../../inherits/tailscale.nix
  ];
  # the  most important stuff first
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  hardware.cpu.intel.updateMicrocode = true; # intel microcode

  system.stateVersion = "23.05";

  # home manager stuff
  home-manager.extraSpecialArgs = {
    dev = true;
    gui = true;
    personal = true;
    emu = true;
    random = true;
    wifi = true;
  };
  home-manager.users.jane = ../../../home/shimmy/home.nix;

  # hardware
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.thermald.enable = true;
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };
  powerManagement.enable = true; # sleep and hibernate
  powerManagement.powertop.enable = true;
  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  # developing the one flatpak thing i need only on shimmy anyways so idc

  xdg.portal.enable = true;
  services.flatpak.enable = true;

  environment.systemPackages = [
    rogauracore
  ];

  # i fucking hate windows
  time.hardwareClockInLocalTime = true;

  time.timeZone = "America/New_York";

  # extra services n such

  services.xrdp = {
    enable = true;
    defaultWindowManager = "i3";
    openFirewall = true;
  };
  # just in case xrdp doesnt work
  services.x2goserver.enable = true;

  services.xserver.libinput.enable = true;
  services.gnome.gnome-keyring.enable = true;
}
