{
  config,
  pkgs,
  lib,
  specialArgs,
  ...
}: let
  inputs = specialArgs.inputs;
in {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      inputs.hy3.packages.${pkgs.system}.default
      inputs.hyprgrass.packages.${pkgs.system}.default
    ];
    extraConfig = ''
      # source the config after
      source = ${../../../cfg/hypr/hyprland.conf}
    '';
  };

  # programs.swaylock = {
  #   enable = true;
  #   settings = {
  #     color = "000000";
  #     font-size = 20;
  #     ignore-empty-password = true;
  #     show-failed-attempts = true;
  #     image = "${../../../images/swaylock.png}";
  #   };
  # };
}
