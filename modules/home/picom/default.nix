{ config, lib, osConfig, pkgs, ... }:
{
  options.Wotan.desktop.picom = {
    enable = lib.mkEnableOption "Picom compositor toggle";
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
      vSync = true;
      settings = {
        # corner-radius = 8.0;
        # round-borders = 1;
        blur = {
          method = "gaussian";
          size = 30;
          deviation = 5.0;
        };
      };
    };
  };
}
