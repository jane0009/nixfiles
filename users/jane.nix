{ lib, config, pkgs, ... }:
# let
#   nu-plugins = (import ../derivations/nu-plugins.nix { inherit pkgs lib; });
# in
rec {
    #
    environment.systemPackages = [
        pkgs.ponysay
        pkgs.carapace
    ];
    users.users.jane = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" "video" "dialout" ];
        shell = pkgs.nushell;
    };
}