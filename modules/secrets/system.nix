{
  config,
  lib,
  pkgs,
  inputs,
  opts,
  ...
}: {
  imports = [inputs.agenix.nixosModules.default];
  age = {
    secrets."id_gitssh" = {
      file = ./secrets/gitssh.age;
      mode = "600";
      owner = "jane";
      group = "users";
    };
    secrets."wifi.env" = {
      file = ./secrets/wifi.age;
      mode = "600";
      owner = "jane";
      group = "users";
    };
    identityPaths = ["/home/jane/.ssh/id_ed25519"];
  };
}
