{
  description = "Ben's NixOS configuration";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs = {
    ags.url = "github:Aylur/ags/v1";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    emacs.url = "github:kaylorben/emacs";
    firefox-addons.inputs.nixpkgs.follows = "nixpkgs";
    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    hyprland.url = "github:hyprwm/Hyprland/29e2e59fdbab8ed2cc23a20e3c6043d5decb5cdc";
    hyprpaper.url = "github:hyprwm/hyprpaper";
    impermanence.url = "github:nix-community/impermanence";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote.url = "github:nix-community/lanzaboote";
    neovim.url = "github:kaylorben/neovim";
    nix-citizen.url = "github:LovingMelody/nix-citizen";
    # nix-eval-jobs.url = "github:nix-community/nix-eval-jobs";
    # nix-eval-jobs.inputs.nixpkgs.follows = "nixpkgs";
    # nix-eval-jobs.inputs.treefmt-nix.follows = "treefmt-nix";
    # nix-eval-jobs.inputs.flake-parts.follows = "flake-parts";
    nix-foundry.url = "github:CaptainMinnette/nix-foundryvtt/cc05672231e76c35616f05777e0881b416e46350";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    # nixcord.url = "github:kaylorben/nixcord/donteatoreo/push-qznoroyymmku";
    nixcord.url = "github:kaylorben/nixcord/hash";
    # nixcord.url = "path:/home/ben/Development/nixcord";
    picom.inputs.nixpkgs.follows = "nixpkgs";
    picom.url = "github:yshui/picom/next";
    stable-nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    split-monitor-workspaces.url = "github:Duckonaut/split-monitor-workspaces/a8e39ff10dfb5ff451416a791a30388a8517e038";
    split-monitor-workspaces.inputs.hyprland.follows = "hyprland";
    stylix.url = "github:danth/stylix";
    swww.url = "github:LGFae/swww";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self, systems, ... }@inputs:
    let
      forAllSystems =
        f: inputs.nixpkgs.lib.genAttrs (import systems) (system: f inputs.nixpkgs.legacyPackages.${system});
      treefmtEval = forAllSystems (pkgs: inputs.treefmt-nix.lib.evalModule pkgs ./treefmt.nix);

      overlays = with inputs; [
        (import ./overlay/default.nix)
        neovim.overlays.default
        (final: prev: {
          star-citizen = inputs.nix-citizen.packages.${prev.system}.star-citizen;
        })
      ];

      homeModules = with inputs; [
        # ags.homeManagerModules.default
        hyprland.homeManagerModules.default
        impermanence.nixosModules.home-manager.impermanence
        # nixcord.homeManagerModules.nixcord
        # stylix.homeManagerModules.stylix
        {
          imports = import ./modules/home;
        }
      ];

      nixosModules = with inputs; [
        disko.nixosModules.disko
        home-manager.nixosModules.home-manager
        hyprland.nixosModules.default
        impermanence.nixosModules.impermanence
        lanzaboote.nixosModules.lanzaboote
        nix-gaming.nixosModules.pipewireLowLatency
        nix-citizen.nixosModules.StarCitizen
        nix-foundry.nixosModules.foundryvtt
        nixos-cosmic.nixosModules.default
        stylix.nixosModules.stylix
        {
          nixpkgs.overlays = overlays;
          nixpkgs.config.allowUnfree = true;

          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit inputs;
          };

          home-manager.sharedModules = homeModules;

          imports = import ./modules/nixos;
        }
      ];
    in
    {
      nixosConfigurations = with inputs; {
        siegmund = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = nixosModules ++ [
            ./systems/siegmund

            {
              home-manager.users.ben = {
                imports = [ ./homes/siegmund/ben ];
              };
            }
          ];
        };

        brunnhilde = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = nixosModules ++ [
            ./systems/brunnhilde
            {
              home-manager.users.ben = {
                imports = [ ./homes/brunnhilde/ben ];
              };
            }
          ];
        };

        wolfram = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = nixosModules ++ [
            ./systems/wolfram

            {
              home-manager.users.ben = {
                imports = [ ./homes/wolfram/ben ];
              };
            }
          ];
        };

        gunther = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = nixosModules ++ [
            (
              { modulesPath, ... }:
              {
                imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];
              }
            )
            ./systems/gunther
          ];
        };
      };
      formatter = forAllSystems (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
      checks = forAllSystems (pkgs: {
        formatting = treefmtEval.${pkgs.system}.config.build.check self;
      });
    };
}
