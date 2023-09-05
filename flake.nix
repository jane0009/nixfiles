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
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    zig.url = "github:mitchellh/zig-overlay";
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, fenix, agenix, nixos-wsl, 
  vscode-server, nixos-hardware, nix-vscode-extensions, zig, ... }@inputs:
    let
      hm = { system ? "x86_64-linux", name ? "jane", specialArgs ? { }, modules ? [ ./home/generic/home.nix ] }:
        home-manager.lib.homeManagerConfiguration {
          inherit modules;

          pkgs = import nixpkgs {
            system = system;
            config.allowUnfree = true;
            overlays = [ fenix.overlays.default ];
          };

          extraSpecialArgs = specialArgs // { inherit name inputs; };
        };

      nixos = { system, modules, specialArgs ? { } }:
        nixpkgs.lib.nixosSystem {
          inherit system modules;

          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
              fenix.overlays.default
              nix-vscode-extensions.overlays.default
              zig.overlays.default
              (import ./derivations/hh3/manual-hh3.nix)
            ];
          };

          specialArgs = specialArgs // { inherit inputs; };
        };
    in {
      homeConfigurations = {
        "jane@sparky" = hm {
          modules = [ ./home/sparky/home.nix ];
        };
        "jane@shimmy" = hm {
          modules = [ ./home/shimmy/home.nix ];
        };
        "jane" = hm {};
      };

      nixosConfigurations = {
        J3B3GX9 = nixos {
          system = "x86_64-linux";
          modules = [
            nixos-wsl.nixosModules.wsl
            vscode-server.nixosModules.default
            home-manager.nixosModules.home-manager
            agenix.nixosModules.default
            ./hosts/defaults.nix
            ./hosts/wsl/config.nix
            ./users/jane.nix
            {
              age = {
                secrets."id_gitssh" = {
                  file = ./secrets/gitssh.age;
                  mode = "600";
                  owner = "jane";
                  group = "users";
                };
                identityPaths = [ "/home/jane/.ssh/id_ed25519" ];
              };
            }
          ];
        };
        shimmy = nixos {
          system = "x86_64-linux";
          modules = [
            vscode-server.nixosModules.default
            home-manager.nixosModules.home-manager
            agenix.nixosModules.default
            ./hosts/defaults.nix
            ./hosts/shimmy/config.nix
            ./hosts/shimmy/hardware.nix
            ./users/jane.nix
            {
              age = {
                secrets."id_gitssh" = {
                  file = ./secrets/gitssh.age;
                  mode = "600";
                  owner = "jane";
                  group = "users";
                };
                identityPaths = [ "/home/jane/.ssh/id_ed25519" ];
              };
            }
          ];
        };
        sparky = nixos {
          system = "x86_64-linux";
          modules = [
            home-manager.nixosModules.home-manager
            agenix.nixosModules.default
            ./hosts/defaults.nix
            ./hosts/sparky/config.nix
            ./hosts/sparky/hardware.nix
            ./users/jane.nix
            {
              age = {
               secrets."id_gitssh" = {
                 file = ./secrets/gitssh.age;
                 mode = "600";
                 owner = "jane";
                 group = "users";
               };
               identityPaths = [ "/home/jane/.ssh/id_ed25519" ];
             };
            }
         ];
        };
        # server config (later)
      };
    };
  }
