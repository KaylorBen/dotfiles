{ config, lib, osConfig, pkgs, ... }:
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
      package = pkgs.picom;
      activeOpacity = 1.0;
      fade = true;
      fadeDelta = 5;
      inactiveOpacity = 0.9;
      shadow = true;
      opacityRules = [
        "100:name *?= 'Firefox' && !focused"
        "95:class_g = 'org.wezfurlong.wezterm' && focused"
      ];
    };
  };
}
