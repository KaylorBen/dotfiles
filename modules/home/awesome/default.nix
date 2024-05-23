{ config, lib, osConfig, pkgs, ... }:
with lib;
let cfg = config.Wotan.desktop.awesome;
in {
  options.Wotan.desktop.awesome = {
    enable = mkOption {
      type = types.bool;
      description = "AwesomeWM";
      default = osConfig.Wotan.desktop.awesome.enable or false;
    };
  };
  config = mkIf cfg.enable {
    Wotan.desktop.picom.enable = mkDefault true;
    home.file.".config/awesome" = {
      source = ./awesome;
      recursive = true;
    };
    services = {
      playerctld.enable = true;
      flameshot = {
        enable = true;
        settings = {
          General = {
            uiColor = "#1f1d2e";
            contrastUiColor = "#6e6a86";
            drawColor = "#eb6f92";
          };
        };
      };
    };

    home.packages = with pkgs; [
      xorg.libxcb
      pamixer
      pa_applet
      xclip
    ];
  };
}
