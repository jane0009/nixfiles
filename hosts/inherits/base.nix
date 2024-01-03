{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  # always enable flakes
  nix.package = pkgs.nixFlakes;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # always present packages
  environment.systemPackages = with pkgs; [
    python3Full # what for???
    util-linux
    busybox
    inputs.agenix.packages."${system}".default
    # for nixfile formatting
    pre-commit
    alejandra
    # because i keep having issues where git is not installed in root
    git
  ];

  networking.networkmanager.enable = true;
  # firewall working properly
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [80 443];
    allowedUDPPortRanges = [
      {
        from = 4000;
        to = 4007;
      }
      {
        from = 8000;
        to = 8010;
      }
    ];
  };

  # privkey openssh on all systems
  services.openssh = {
    enable = true;
    openFirewall = true;
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
