{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.Wotan.desktop.hyprland;
in
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

  config = lib.mkIf cfg.enable {
    programs.light.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    security.pam.services.swaylock.text = ''
      auth include login
    '';
    # xdg.portal = {
    #  enable = true;
    #  extraPortals = with pkgs; [xdg-desktop-portal-hyprland];
    #  xdgOpenUsePortal = true;
    # };
    programs.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      xwayland = {
        enable = true;
      };
    };
  };
}
