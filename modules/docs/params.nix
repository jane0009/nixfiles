{lib, ...}:
with lib; {
  has = ["system"];
  options = {
    documentation = lib.mkOption {
      type = types.bool;
      default = true;
      description = "Whether to build documentation";
    };
  };
}
