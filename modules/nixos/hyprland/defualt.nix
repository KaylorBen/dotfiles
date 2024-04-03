{ config, lib, pkgs, ... }:
{
  options.Wotan.desktop.hyprland = {
    enable = lib.mkEnableOption "hyprland";
    extraAutoStart = lib.mkOption {
      # List of strings
      type = with lib.types; listOf str;
      default = [ ];
    };
    extraSettings = lib.mkOption {
      type = lib.types.attrs;
      default = { };
    };
  };

  config = lib.mkIf config.Wotan.desktop.hyprland.enable {
    programs.light.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    programs.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      xwayland.enable = true;
    };
  };
}
