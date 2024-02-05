{
  config,
  lib,
  ...
}: (options: let
  mkWirelessStatic = {
    type,
    ssid,
    interface,
    password,
    auth-alg,
    key-mgmt,
    gateway,
    ip,
  }:
    {
      connection = {
        inherit type;
        id = ssid;
        interface-name = interface;
      };
      ipv6 = {
        method = "ignore";
      };
      ipv4 = {
        method = "manual";
        dns = "1.1.1.1;${gateway};";
        address1 = "${ip},${gateway}";
      };
    }
    // builtins.listToAttrs [
      {
        name = type;
        value = {
          inherit ssid;
          mode = "infrastructure";
        };
      }
      {
        name = "${type}-security";
        value = {
          inherit auth-alg key-mgmt;
          psk = password;
        };
      }
    ];
  mkWirelessDHCP = {
    type,
    ssid,
    interface,
    password,
    auth-alg,
    key-mgmt,
  }:
    {
      connection = {
        inherit type;
        id = ssid;
        interface-name = interface;
      };
      ipv6 = {
        method = "ignore";
      };
      ipv4 = {
        method = "auto";
      };
    }
    // builtins.listToAttrs [
      {
        name = type;
        value = {
          inherit ssid;
          mode = "infrastructure";
        };
      }
      {
        name = "${type}-security";
        value = {
          inherit auth-alg key-mgmt;
          psk = password;
        };
      }
    ];
  mkEthernet = {
    type,
    name,
    interface,
    gateway,
    ip,
  }: {
    connection = {
      inherit type;
      id = name;
    };
    ipv6 = {
      method = "ignore";
    };
    ipv4 = {
      method = "manual";
      dns = "1.1.1.1;${gateway};";
      address1 = "${ip},${gateway}";
    };
  };
  wirelessTypes = ["802-11-wireless" "wifi"];
in {
  environmentFiles = [config.age.secrets."wifi.env".path];
  profiles = builtins.listToAttrs (builtins.map (option: {
      name = "${option.name}.nmconnection";
      value =
        if (lib.lists.any (type: type == option.type) wirelessTypes)
        then
          (
            if option ? static
            then
              mkWirelessStatic {
                type = option.type;
                ssid = option.name;
                interface = option.interface;
                password = option.password;
                auth-alg = option.auth-alg;
                key-mgmt = option.key-mgmt;
                gateway = option.gateway;
                ip = option.ip;
              }
            else
              mkWirelessDHCP {
                type = option.type;
                ssid = option.name;
                interface = option.interface;
                password = option.password;
                auth-alg = option.auth-alg;
                key-mgmt = option.key-mgmt;
              }
          )
        else
          mkEthernet {
            type = option.type;
            name = option.name;
            interface = option.interface;
            gateway = option.gateway;
            ip = option.ip;
          };
    })
    options);
})
