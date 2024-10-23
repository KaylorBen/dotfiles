{
  description = "Ben's NixOS configuration powered by Snowfall";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs = {
    ags.url = "github:Aylur/ags";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    firefox-addons.inputs.nixpkgs.follows = "nixpkgs";
    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    hyprwm-contrib.inputs.nixpkgs.follows = "nixpkgs";
    hyprwm-contrib.url = "github:hyprwm/contrib";
    hypridle.inputs.nixpkgs.follows = "nixpkgs";
    hypridle.url = "github:hyprwm/hypridle";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:vaxerski/Hyprland";
    hyprpaper.inputs.nixpkgs.follows = "nixpkgs";
    hyprpaper.url = "github:hyprwm/hyprpaper";
    impermanence.url = "github:nix-community/impermanence";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote.url = "github:nix-community/lanzaboote";
    neovim.url = "github:kaylorben/neovim";
    nix-citizen.url = "github:LovingMelody/nix-citizen";
    nix-citizen.inputs.nix-gaming.follows = "nix-gaming";
    nix-citizen.inputs.nixpkgs.follows = "nixpkgs";
    nix-citizen.inputs.treefmt-nix.follows = "treefmt-nix";
    nix-eval-jobs.url = "github:nix-community/nix-eval-jobs";
    nix-eval-jobs.inputs.nixpkgs.follows = "nixpkgs";
    nix-eval-jobs.inputs.treefmt-nix.follows = "treefmt-nix";
    nix-eval-jobs.inputs.flake-parts.follows = "flake-parts";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-gaming.inputs.nixpkgs.follows = "nixpkgs";
    nix-gaming.inputs.flake-parts.follows = "flake-parts";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index.inputs.nixpkgs.follows = "nixpkgs";
    nix-index.url = "github:nix-community/nix-index";
    nix-minecraft.inputs.nixpkgs.follows = "nixpkgs";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nixos-anywhere.inputs.disko.follows = "disko";
    nixos-anywhere.inputs.nixpkgs.follows = "nixpkgs";
    nixos-anywhere.inputs.treefmt-nix.follows = "treefmt-nix";
    nixos-anywhere.url = "github:nix-community/nixos-anywhere";
    nixos-cosmic.inputs.nixpkgs.follows = "nixpkgs";
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
    nixpkgs-wayland.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-wayland.inputs.nix-eval-jobs.follows = "nix-eval-jobs";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    picom.inputs.nixpkgs.follows = "nixpkgs";
    picom.url = "github:yshui/picom/next";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";
    snowfall-lib.url = "github:snowfallorg/lib/dev";
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
    in
    inputs.snowfall-lib.mkFlake {
      inherit inputs;

      src = ./.;
      snowfall.namespace = "Wotan";
      overlays = with inputs; [
        nix-minecraft.overlays.default
        neovim.overlays.default
        # nixpkgs-wayland.overlays.default
      ];
      home.users."ben@Siegmund".modules = with inputs; [
        ags.homeManagerModules.default
        hyprland.homeManagerModules.default
        impermanence.nixosModules.home-manager.impermanence
        nix-index-database.hmModules.nix-index
        snowfall-lib.homeModules.user
        nixcord.homeManagerModules.nixcord
        stylix.homeManagerModules.stylix
      ];
      systems.modules.nixos = with inputs; [
        (
          { lib, ... }:
          {
            system.stateVersion = lib.Wotan.stateVersion.nixos;
          }
        )
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
      ];
      channels-config = {
        allowUnfree = true;
      };
    }
    // {
      formatter = forAllSystems (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
      checks = forAllSystems (pkgs: {
        formatting = treefmtEval.${pkgs.system}.config.build.check self;
      });
    };
}
