{ config, lib, pkgs, ... }:
{
  options.Wotan.desktop.awesome = {
    enable = lib.mkEnableOption "awesome wm";
  };

  config = lib.mkIf config.Wotan.desktop.awesome.enable {
    programs.light.enable = true;
    services.xserver = {
      windowManager.awesome = {
        enable = true;
        package = pkgs.awesome;
      };
      displayManager = {
        gdm.enable = true;
        defaultSession = "none+awesome";
      };
    };
  };
}
