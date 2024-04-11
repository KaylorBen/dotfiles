{ config, lib, osConfig, pkgs, ... }:
{
  options.Wotan.desktop.awesome = {
    enable = lib.mkOption {
      type = lib.types.bool;
      description = "AwesomeWM";
      default = osConfig.Wotan.desktop.awesome.enable or false;
    };
  };
  config = lib.mkIf config.Wotan.desktop.awesome.enable {
    Wotan.desktop.picom.enable = lib.mkDefault true;
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
