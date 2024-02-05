{lib, ...}:
with lib; {
  has = ["system" "home"];
  options = {
    network = mkOption {
      type = types.listOf (types.submodule {
        options = {
          type = mkOption {
            type = types.enum ["wifi" "ethernet"];
          };
          name = mkOption {
            type = types.str;
          };
          interface = mkOption {
            type = types.str;
          };
          password = mkOption {
            type = types.nullOr (types.str);
          };
          auth-alg = mkOption {
            type = types.nullOr (types.enum ["open" "shared"]);
          };
          key-mgmt = mkOption {
            type = types.nullOr (types.enum ["wpa-psk" "wpa-eap"]);
          };
          static = mkOption {
            type = types.bool;
            default = false;
          };
          gateway = mkOption {
            type = types.nullOr (types.str);
          };
          ip = mkOption {
            # shoutout to aly. thanks aly
            type = types.nullOr (types.strMatching "^(([1-9]?\d|1\d\d|2([0-4]\d|5[0-5]))\.){3}(([1-9]?\d|1\d\d|2([0-4]\d|5[0-5]))\/)([1-2]?\d|3[0-2])$");
          };
        };
      });
      description = "network settings";
      default = [];
    };
  };
}
