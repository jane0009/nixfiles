{
  config,
  lib,
  opts,
  pkgs,
  ...
}: {
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  environment.systemPackages =
    lib.optionals (
      (builtins.hasAttr opts "wm") && opts.wm == "x11"
    ) [
      pkgs.blueberry
    ]
    ++ lib.optionals (
      (builtins.hasAttr opts "wm") && opts.wm == "wayland"
    ) [
      pkgs.blueman
    ];

  services.blueman.enable = (builtins.hasAttr opts "wm") && opts.wm == "wayland";
}
