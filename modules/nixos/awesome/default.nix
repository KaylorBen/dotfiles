{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.Wotan.desktop.awesome;
in
{
  options.Wotan.desktop.awesome = {
    enable = mkEnableOption "Awesome WM";
  };

  config = mkIf cfg.enable {
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
