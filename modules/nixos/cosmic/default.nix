{ config, lib, ... }:
with lib;
let cfg = config.Wotan.desktop.cosmic;
in {
  options.Wotan.desktop.cosmic = {
    enable = mkEnableOption "Cosmic DE";
  };

  config = mkIf cfg.enable {
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;
    services.displayManager.defaultSession = "cosmic";
  };
}
