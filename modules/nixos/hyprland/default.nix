{
  config,
  lib,
  pkgs,
  inputs,
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

    nix.settings =
      let
        substituters = [
          "https://hyprland.cachix.org"
        ];
        trusted-public-keys = [
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        ];
      in {
          inherit substituters trusted-public-keys;
          trusted-substituters = substituters;
          extra-trusted-public-keys = trusted-public-keys;
        };

    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
      xwayland = {
        enable = true;
      };
    };
  };
}
