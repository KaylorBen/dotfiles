{ config, lib, pkgs, ... }:
{
  options.Wotan.desktop.awesome = {
    enable = lib.mkEnableOption "awesome wm";
  };

  config = lib.mkIf config.Wotan.desktop.awesome.enable {
    services.xserver = {
      windowManager.awesome = {
        enable = true;
        package = pkgs.awesome;
      };
      # TODO move this to its own place since no awesome specific
      displayManager = {
        lightdm.enable = true;
        defaultSession = "none+awesome";
      };
    };
  };
}
