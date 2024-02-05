{
  lib,
  config,
  pkgs,
  ...
}: {
  # fonts
  fonts.packages = with pkgs; [
    unifont
    font-awesome
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    corefonts
    courier-prime
    (nerdfonts.override {fonts = ["FiraCode" "Inconsolata" "Iosevka" "Terminus"];})
  ];
  fonts.fontDir.enable = true;
  fonts.fontconfig.defaultFonts.monospace = ["Courier Prime" "Inconsolata" "Terminess Nerd Font"];
}
