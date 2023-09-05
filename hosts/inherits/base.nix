{ lib, config, pkgs, inputs, ... }:

{
    # always enable flakes
    nix.package = pkgs.nixFlakes;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    
    # always present packages
    environment.systemPackages = with pkgs; [
      python3Full # what for???
      util-linux
      inputs.agenix.packages."${system}".default
    ];

    networking.networkmanager.enable = true;
    
    # privkey openssh on all systems
    services.openssh = {
        enable = true;
        settings.PasswordAuthentication = false;
    };

    # home-manager
    home-manager.useGlobalPkgs = true;
    home-manager.extraSpecialArgs = {
        server = false;
        dev = false;
        gui = false;
        personal = false;
        emu = false;
        random = false;
        wifi = false;
    };

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    hardware.enableAllFirmware = true;
}
