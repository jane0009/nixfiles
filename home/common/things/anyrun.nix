{
  lib,
  pkgs,
  specialArgs,
  ...
}: rec {
  imports = [
    specialArgs.inputs.anyrun.homeManagerModules.default
  ];

  # redundant, but at this point my computer is basically a jet engine
  # trying to build this
  nix.settings = {
    builders-use-substitutes = true;
    substituters = ["https://hyprland.cachix.org" "https://anyrun.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="];
  };

  programs.anyrun = {
    enable = true;
    package = specialArgs.inputs.anyrun.packages.${pkgs.system}.anyrun-with-all-plugins;
    config = {
      width = {fraction = 0.3;};
      # position = "top";
      # verticalOffset = { absolute = 0; };
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = false;
      closeOnClick = false;
      showResultsImmediately = false;
      maxEntries = null;
    };
    # extraCss = ''
    #   .some_class {
    #     background: red;
    #   }
    # '';
    # extraConfigFiles."some-plugin.ron".text = ''
    #   Config(
    #     // for any other plugin
    #     // this file will be put in ~/.config/anyrun/some-plugin.ron
    #     // refer to docs of xdg.configFile for available options
    #   )
    # '';
  };
}
