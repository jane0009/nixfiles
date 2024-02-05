{
  description = "A very basic flake";

  inputs = {
    nixpkgs = {
      url = "nixpkgs/nixos-unstable";
    };
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:rycee/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hy3 = {
      url = "github:outfoxxed/hy3";
      inputs.hyprland.follows = "hyprland";
    };
    hyprgrass = {
      url = "github:horriblename/hyprgrass";
      inputs.hyprland.follows = "hyprland";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    zig.url = "github:mitchellh/zig-overlay";
    nixos-generators.url = "github:nix-community/nixos-generators";
    colmena.url = "github:zhaofengli/colmena";
  };

  outputs = {
    nixpkgs,
    home-manager,
    fenix,
    agenix,
    nixos-wsl,
    vscode-server,
    nix-vscode-extensions,
    nixos-generators,
    colmena,
    zig,
    hyprland,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    systemsList = builtins.readDir ./hosts/systems;
    systems = lib.attrsets.mapAttrsToList (name: value: name) (
      lib.attrsets.filterAttrs (name: value: value == "directory") systemsList
    );

    containers = import ./hosts/containers.nix;

    hm = {
      system ? "x86_64-linux",
      name ? "jane",
      specialArgs ? {},
      modules ? [./home/generic/home.nix],
    }:
      home-manager.lib.homeManagerConfiguration {
        inherit modules;

        pkgs = import nixpkgs {
          system = system;
          config.allowUnfree = true;
          overlays = [fenix.overlays.default];
        };

        extraSpecialArgs = specialArgs // {inherit name inputs;};
      };

    moduleLib = import ./extraLibs/modules.nix {
      inherit lib inputs;
    };
    # nixos = moduleLib.nixos;
    # genSystem = moduleLib.genSystem;
    # genTarball = moduleLib.genTarball;
    # nixos = {
    #   system,
    #   modules,
    #   specialArgs ? {},
    # }:
    #   nixpkgs.lib.nixosSystem {
    #     inherit system;
    #     modules =
    #       modules
    #       ++ [
    #       ];
    #     pkgs = import nixpkgs {
    #       inherit system;
    #       config.allowUnfree = true;
    #       overlays = [
    #         fenix.overlays.default
    #         nix-vscode-extensions.overlays.default
    #         zig.overlays.default
    #         (import ./derivations/hh3/manual-hh3.nix)
    #       ];
    #     };
    #     specialArgs = specialArgs // {inherit inputs;};
    #   };
    # moduleList = {
    #   "container" = [
    #     {
    #       imports = ["${nixpkgs}/nixos/modules/virtualisation/lxc-container.nix" ./hosts/inherits/container.nix];
    #     }
    #   ];
    #   "wsl" = [nixos-wsl.nixosModules.wsl];
    #   "vscode-server" = [vscode-server.nixosModules.default];
    #   "hm" = [
    #     home-manager.nixosModules.home-manager
    #   ];
    #   "hyprland" = [
    #     hyprland.nixosModules.default
    #     {
    #       nix.settings = {
    #         builders-use-substitutes = true;
    #         substituters = ["https://cache.nixos.org" "https://hyprland.cachix.org" "https://anyrun.cachix.org"];
    #         trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="];
    #       };
    #     }
    #   ];
    #   "agenix" = [
    #     agenix.nixosModules.default
    #     {
    #       age = {
    #         secrets."id_gitssh" = {
    #           file = ./secrets/gitssh.age;
    #           mode = "600";
    #           owner = "jane";
    #           group = "users";
    #         };
    #         secrets."wifi.env" = {
    #           file = ./secrets/wifi.age;
    #           mode = "600";
    #           owner = "jane";
    #           group = "users";
    #         };
    #         identityPaths = ["/home/jane/.ssh/id_ed25519"];
    #       };
    #     }
    #   ];
    # };
    # mapModuleStrings = (
    #   hostname: modules: users:
    #     [
    #       ./hosts/defaults.nix
    #     ]
    #     ++ lib.optionals (builtins.pathExists ./hosts/systems/${hostname}/hardware.nix) [
    #       ./hosts/systems/${hostname}/hardware.nix
    #     ]
    #     ++ lib.lists.flatten (
    #       builtins.map (
    #         name: lib.attrsets.getAttrFromPath [name] moduleList
    #       ) (
    #         builtins.filter (
    #           name: lib.attrsets.hasAttrByPath [name] moduleList
    #         )
    #         modules
    #       )
    #     )
    #     # this HAS to be last due to priority issues
    #     ++ [./hosts/systems/${hostname}/config.nix]
    #     ++ builtins.map (user: ./users/${user}.nix) users
    #     ++ [
    #       {
    #         networking.hostName = hostname;
    #       }
    #     ]
    # );
    # overlayList = {};
    # mapOverlayStrings = hostname: overlays: [];
    # genSystem = {systemName}: let
    #   configFile = ./hosts/systems/${systemName}/config.nix;
    #   hasCustomDefs = builtins.pathExists ./hosts/systems/${systemName}/params.nix;
    #   defaultParams = import ./hosts/default-params.nix;
    #   params =
    #     if hasCustomDefs
    #     then defaultParams // (import ./hosts/systems/${systemName}/params.nix)
    #     else defaultParams;
    # in
    #   nixos {
    #     system = params.system;
    #     modules = mapModuleStrings systemName params.modules params.users;
    #   };
    # genTarball = {systemName}: let
    #   configFile = ./hosts/systems/${systemName}/config.nix;
    #   hasCustomDefs = builtins.pathExists ./hosts/systems/${systemName}/params.nix;
    #   defaultParams = import ./hosts/default-params.nix;
    #   params =
    #     if hasCustomDefs
    #     then defaultParams // (import ./hosts/systems/${systemName}/params.nix)
    #     else defaultParams;
    #   pkgcfg = import nixpkgs {
    #     system = params.system;
    #     config.allowUnfree = true;
    #     overlays = mapOverlayStrings systemName params.overlays;
    #   };
    # in
    #   nixos-generators.nixosGenerate {
    #     system = params.system;
    #     format = "proxmox-lxc";
    #     pkgs = pkgcfg;
    #     modules =
    #       (mapModuleStrings systemName params.modules params.users)
    #       ++ [
    #         {
    #           # whyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
    #           config.nixpkgs.config.allowUnfree = true;
    #         }
    #       ];
    #     specialArgs = {
    #       containerId = params.containerId;
    #       pkgs = pkgcfg;
    #       inherit inputs;
    #     };
    #   };
  in {
    homeConfigurations = {
      "jane@sparky" = hm {
        modules = [./home/sparky/home.nix];
      };
      "jane@shimmy" = hm {
        modules = [./home/shimmy/home.nix];
      };
      "jane" = hm {};
    };
    nixosConfigurations = builtins.listToAttrs (builtins.map (systemName: {
        name = systemName;
        value = moduleLib.genSystem {
          inherit systemName;
        };
      })
      systems);

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
    packages.x86_64-linux = builtins.listToAttrs ((builtins.map (ct: {
          name = ct;
          value = moduleLib.genTarball {
            systemName = ct;
          };
        })
        containers)
      ++ [
        {
          name = "default";
          value = moduleLib.genTarball {
            systemName = "hillbilly";
          };
        }
      ]);
  };
}
