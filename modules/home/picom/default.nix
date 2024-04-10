{ config, lib, osConfig, ... }:
{
  options.Wotan.desktop.picom = {
    enable = lib.mkOption {
      type = lib.types.bool;
      description = "Picom compositor toggle";
      default = osConfig.Wotan.desktop.awesome.enable or false;
    };
  };
  config = lib.mkIf config.Wotan.desktop.picom.enable {
    services.picom = {
      enable = true;
      activeOpacity = 1.0;
      fade = true;
      fadeDelta = 5;
      inactiveOpacity = 0.8;
      shadow = true;
    };
  };
}
