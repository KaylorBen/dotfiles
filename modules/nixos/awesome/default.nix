{ config, lib, pkgs, ... }:
let cfg = config.Wotan.desktop.awesome;
in {
  options.Wotan.desktop.awesome = {
    enable = lib.mkdEnableOption "awesome wm";
  };

  config = lib.mkIf cfg.enable {
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
