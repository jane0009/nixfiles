{
  lib,
  pkgs,
  specialArgs,
  ...
}: {
  # dotcfg-common should be imported in the home file itself
  # this is for config specific things
  imports = [
  ];
}
