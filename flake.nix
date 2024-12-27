{
  description = "Ben's NixOS configuration";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs = {
    ags.url = "github:Aylur/ags/v1";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    firefox-addons.inputs.nixpkgs.follows = "nixpkgs";
    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    ghostty.url = "git+ssh://git@github.com/ghostty-org/ghostty";
    # ghostty.inputs.nixpkgs-stable.follows = "nixpkgs";
    # ghostty.inputs.nixpkgs-unstable.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    hyprwm-contrib.url = "github:hyprwm/contrib";
    hypridle.url = "github:hyprwm/hypridle";
    hyprland.url = "github:vaxerski/Hyprland";
    hyprpaper.url = "github:hyprwm/hyprpaper";
    impermanence.url = "github:nix-community/impermanence";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote.url = "github:nix-community/lanzaboote";
    neovim.url = "github:kaylorben/neovim";
    nix-citizen.url = "github:LovingMelody/nix-citizen";
    nix-eval-jobs.url = "github:nix-community/nix-eval-jobs";
    nix-eval-jobs.inputs.nixpkgs.follows = "nixpkgs";
    nix-eval-jobs.inputs.treefmt-nix.follows = "treefmt-nix";
    nix-eval-jobs.inputs.flake-parts.follows = "flake-parts";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-minecraft.inputs.nixpkgs.follows = "nixpkgs";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nixos-anywhere.inputs.disko.follows = "disko";
    nixos-anywhere.inputs.nixpkgs.follows = "nixpkgs";
    nixos-anywhere.inputs.treefmt-nix.follows = "treefmt-nix";
    nixos-anywhere.url = "github:nix-community/nixos-anywhere";
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
    nixos-generators.inputs.nixlib.follows = "nixpkgs";
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-xivlauncher-rb.url = "github:drakon64/nixos-xivlauncher-rb";
    # nixcord.url = "path:/home/ben/Development/nixcord"; # Development
    nixcord.url = "github:kaylorben/nixcord";
    # nixcord.url = "github:DontEatOreo/nixcord/add-vencord-unstable";
    nixpkgs-wayland.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-wayland.inputs.nix-eval-jobs.follows = "nix-eval-jobs";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    picom.inputs.nixpkgs.follows = "nixpkgs";
    picom.url = "github:yshui/picom/next";
    stable-nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    split-monitor-workspaces.url = "github:Duckonaut/split-monitor-workspaces";
    split-monitor-workspaces.inputs.hyprland.follows = "hyprland";
    stylix.url = "github:danth/stylix";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
    xdg-desktop-portal-hyprland.inputs.nixpkgs.follows = "nixpkgs";
    xdg-desktop-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
  };

  outputs =
    { self, systems, ... }@inputs:
    let
      forAllSystems =
        f: inputs.nixpkgs.lib.genAttrs (import systems) (system: f inputs.nixpkgs.legacyPackages.${system});
      treefmtEval = forAllSystems (pkgs: inputs.treefmt-nix.lib.evalModule pkgs ./treefmt.nix);

      overlays = with inputs; [
        (import ./overlay/default.nix)
        nix-minecraft.overlays.default
        neovim.overlays.default
        # nixpkgs-wayland.overlays.default
        (final: prev: {
          star-citizen = inputs.nix-citizen.packages.${prev.system}.star-citizen;
          cava = inputs.stable-nixpkgs.legacyPackages.${prev.system}.cava;
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
        nix-flatpak.nixosModules.nix-flatpak
        nix-gaming.nixosModules.pipewireLowLatency
        nix-citizen.nixosModules.StarCitizen
        nix-minecraft.nixosModules.minecraft-servers
        nixos-cosmic.nixosModules.default
        nixos-generators.nixosModules.all-formats
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
      };
      formatter = forAllSystems (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
      checks = forAllSystems (pkgs: {
        formatting = treefmtEval.${pkgs.system}.config.build.check self;
      });
    };
}
