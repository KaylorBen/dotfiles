{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.Wotan.gaming;
in
{
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
      enable = mkEnableOption "Enable Star Citizen" // {
        default = true;
      };
    };
  };

  config = mkIf cfg.enable {
    nix-citizen.starCitizen = {
      inherit (cfg.starCitizen) enable;
      package = pkgs.star-citizen;
      umu.enable = false;
      disableEAC = false;
      preCommands =
        let
          vars = {
            DXVK_HUUD = "compiler";
            MANGO_HUD = 1;
            NVPRESENT_ENABLE_SMOOTH_MOTION = 1;
          };
        in
        ''
          ${toShellVars vars}
        '';
      patchXwayland = false;
    };
    zramSwap = {
      inherit (cfg.zram) enable memoryPercent;
    };
    programs = {
      gamemode = {
        enable = true;
        settings = {
          general = {
            softrealtime = "auto";
            renice = 15;
          };
        };
      };
      gamescope = {
        enable = true;
        capSysNice = false;
      };
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        extraCompatPackages = with pkgs; [ proton-ge-bin ];
        extraPackages = with pkgs; [
          lsfg-vk
          lsfg-vk-ui
          gale
        ];
        protontricks.enable = true;
        # platformOptimizations.enable = true;
      };
    };

    services = with pkgs; {
      # sunshine = {
      #   enable = true;
      #   openFirewall = true;
      #   package = pkgs.sunshine.override { cudaSupport = true; };
      #   capSysAdmin = true;
      # };
      ananicy = {
        enable = true;
        package = pkgs.ananicy-cpp;
        rulesProvider = pkgs.ananicy-cpp;
        extraRules = [
          {
            "name" = "gamescope";
            "nice" = -20;
          }
        ];
      };
      xserver.modules = [ xorg.xf86inputjoystick ];
      udev.packages = [ game-devices-udev-rules ];
    };
    nix.settings =
      let
        substituters = [
          "https://nix-gaming.cachix.org"
          "https://nix-citizen.cachix.org"
        ];
        trusted-public-keys = [
          "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
          "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo="
        ];
      in
      {
        inherit substituters trusted-public-keys;
        trusted-substituters = substituters;
        extra-trusted-public-keys = trusted-public-keys;
      };

    security.pam.loginLimits = [
      {
        domain = "*";
        type = "soft";
        item = "memlock";
        value = "unlimited";
      }
      {
        domain = "*";
        type = "hard";
        item = "memlock";
        value = "unlimited";
      }
    ];

    environment.systemPackages = with pkgs; [
      crawl
      bottles
      fflogs
      goverlay
      lug-helper
      lutris
      # mangohud
      moonlight-qt
      # oxce-plus
      protontricks
      starsector
      steamcmd
      xivlauncher
      winetricks
      wowup-cf

      wine-astral

      (pkgs.rsi-launcher.override (_: {
        extraLibs =
          _:
          config.hardware.graphics.extraPackages
          ++ [
            config.hardware.graphics.package
            pkgs.lsfg-vk
          ];
        extraEnvVars = {
          DXVK_HUD = "compiler";
          MANGO_HUD = 1;
          NVPRESENT_ENABLE_SMOOTH_MOTION = 1;
        };
      }))

      # (xivlauncher-rb.override {
      #   useGameMode = true;
      #   nvngxPath = "${config.hardware.nvidia.package}/lib/nvidia/wine";
      # })
    ];

    # boot.kernelPackages = cfg.kernel;

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
      steam-hardware.enable = true;
    };

    Wotan.sound.enable = true;
  };
}
