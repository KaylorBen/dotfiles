{ config, lib, pkgs, ... }:
let cfg = config.Wotan.desktop.awesome;
in {
  options.Wotan.desktop.awesome = {
    enable = lib.mkEnableOption "awesome wm";
  };

  config = lib.mkIf cfg.enable {
    programs.light.enable = true;
    services.xserver = {
      windowManager.awesome = {
        enable = true;
        package = pkgs.awesome;
      };
      displayManager = {
        gdm.enable = true;
      };
    };
    services.displayManager.defaultSession = "none+awesome";
  };
}
