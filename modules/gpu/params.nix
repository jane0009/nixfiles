{lib, ...}:
with lib; {
  requires = ["base"];
  has = ["system"];
  options = {
    gpu = lib.mkOption {
      type = types.enum ["nvidia" "amd" "generic"];
      description = "The gpu drivers to use";
      default = "generic";
    };
  };
}
