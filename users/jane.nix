{
  lib,
  config,
  pkgs,
  ...
}:
# let
#   nu-plugins = (import ../derivations/nu-plugins.nix { inherit pkgs lib; });
# in
rec {
  #
  environment.systemPackages = [
    pkgs.nushell
    pkgs.ponysay
    pkgs.fortune
    pkgs.carapace
  ];
  users = {
    mutableUsers = false;
    users.jane = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "video" "dialout"];
      shell = pkgs.nushell;
      hashedPassword = "$y$j9T$00e7QCLjY0neHiJyajGPP/$AFvMkZQGPkAKcJtub0nLU3nviptFzx0hHaOmqoYZxV1";
    };
  };
}
