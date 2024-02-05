{lib, ...}:
with lib; {
  requires = ["docs" "network"];
  has = ["home" "system"];
  options = {
    ssd = mkOption {
      type = types.bool;
      default = false;
      description = "Enable SSD optimizations";
    };
  };
}
