{
  lib,
  opts,
  ...
}: {
  imports =
    lib.optionals (opts.wm == "wayland") [
      ./system-wayland.nix
    ]
    ++ lib.optionals (opts.wm == "x11") [
      ./system-x11.nix
    ];
}
