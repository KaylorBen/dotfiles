{ config, lib, pkgs, ... }:
with lib;
let cfg = config.Wotan.gaming;
in {
  options.Wotan.gaming = {
    enable = mkEnableOption "Enable gaming specific configs";
    remotePlay = mkEnableOption "Enable settings for remote play";
    kernel = mkOption {
      type = types.raw;
      default = pkgs.linuxPackages_latest;
      description = "Set kernel";
    };
    zram = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable ZRam - Star Citizen needs it <40G";
      };
      memoryPercent = mkOption {
        type = types.int;
        default = 100;
        inherit (options.zramSwap.memoryPercent) description;
      };
    };
    starCitizen = {
      enable = mkEnableOption "Enable Star Citizen" // { default = true; };
    };
  };

  config = mkIf cfg.enable {
    nix-citizen.starCitizen = {
      inherit (cfg.starCitizen) enable;
      preCommands = ''
        export DXVK_HUD=compiler;
        export MANGO_HUD=1;
      '';
      helperScript.enable = true;
    };
    zramSwap.enable = cfg.zram.enable;
    zramSwap.memoryPercent = cfg.zram.memoryPercent;
    programs.gamemode.enable = true;
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
    };

    services = with pkgs; {
      xserver.modules = [ xorg.xf86inputjoystick ];
      udev.packages = [ game-devices-udev-rules ];
    };
    nix.settings = let
      substituters = [ "https://nix-gaming.cachix.org" ];
      trusted-public-keys = [
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      ];
    in {
      inherit substituters trusted-public-keys;
      trusted-substituters = substituters;
      extra-trusted-public-keys = trusted-public-keys;
    };

    environment.systemPackages = with pkgs; [
      fflogs
      gamescope
      goverlay
      lug-helper
      lutris
      mangohud
      moonlight-qt
      protontricks
      steam
      steamcmd
      steam-tui
      xivlauncher
      winetricks
      wowup

      (wineWowPackages.full.override {
        wineRelease = "staging";
        mingwSupport = true;
      })
    ];

    boot.kernelPackages = cfg.kernel;

    hardware = {
      graphics = {
        enable = true;
        driSupport32Bit = true;
      };
      steam-hardware.enable = true;
    };

    Wotan.sound.enable = true;
  };
}
