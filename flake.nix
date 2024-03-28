# flake.nix
{
  description = "NixOS configuration of Ben";

  nixConfig = {
    substituters = [
      "https://cache.nixos.org"

      # Prism Launcher Cache
      # "https://cache.garnix.io"

      # nix community's cache server
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="

      # "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="

      # nix community's cache server public key
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
  inputs = {
    firefox-addons.inputs.nixpkgs.follows = "nixpkgs";
    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    nix-minecraft.inputs.nixpkgs.follows = "nixpkgs";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    prismlauncher.inputs.nixpkgs.follows = "nixpkgs";
    prismlauncher.url = "github:PrismLauncher/PrismLauncher";
  };

  outputs = {self, nixpkgs, nixpkgs-stable, home-manager, prismlauncher, ...}@inputs:
    let
      system = "x86_64-linux";
      overlay-stable = final: prev: {
        stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
      };
    in {
      nixosConfigurations = {
        benix = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {inherit inputs;};
          modules = [
            ./hosts/benix

            ({ config, pkgs, ...}: {nixpkgs.overlays = [
              overlay-stable
              prismlauncher.overlays.default
              (import ./overlays.nix)
            ];})

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.ben = {
                imports = 
                [ ./home
                  ./home/awesome
                  ./home/programs/gaming.nix
                  ./home/programs/grobi.nix
                ];
              };
            }

            {
              nix.settings.trusted-users = [ "ben" ];
            }
          ];
        };
        nixtop = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            ./hosts/nixtop

            ({ config, pkgs, ...}: {nixpkgs.overlays = [
              overlay-stable
              (import ./overlays.nix)
            ];})

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.ben = {
                imports =
                [ ./home
                  ./home/sway
                ];
              };
            }

            {
              nix.settings.trusted-users = [ "ben" ];
            }
          ];
        };
      };
    };
}
