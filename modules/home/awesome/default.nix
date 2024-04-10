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
    home.file.".config/awesome" = {
      source = ./awesome;
      recursive = true;
    };
    services.playerctld.enable = true;

    home.packages = with pkgs; [
      pamixer
      pa_applet
      xclip
    ];
  };
}
