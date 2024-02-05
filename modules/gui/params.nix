{lib, ...}:
with lib; {
  requires = ["base" "gpu"];
  has = ["home" "system"];
  options = {
    wm = lib.mkOption {
      type = types.enum ["wayland" "x11"];
      description = "The window manager to use";
      default = "x11";
    };
  };
}
