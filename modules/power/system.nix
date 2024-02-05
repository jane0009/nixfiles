{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
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
}
