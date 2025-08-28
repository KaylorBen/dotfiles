{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.Wotan.desktop.niri;
in
{
  options.Wotan.desktop.niri = {
    enable = lib.mkEnableOption "niri";
  };

  config = lib.mkIf cfg.enable {
    programs.light.enable = true;
    services = {
      greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${pkgs.tuigreet}/bin/tuigreet --time";
            user = "greeter";
          };
        };
      };
      graphical-desktop.enable = true;
      xserver.desktopManager.runXdgAutostartIfNone = true;
    };
    security.pam.services.swaylock.text = ''
      auth include login
    '';

    # nix.settings =
    #   let
    #     substituters = [
    #       "https://hyprland.cachix.org"
    #     ];
    #     trusted-public-keys = [
    #       "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    #     ];
    #   in
    #   {
    #     inherit substituters trusted-public-keys;
    #     trusted-substituters = substituters;
    #     extra-trusted-public-keys = trusted-public-keys;
    #   };

    programs = {
      niri = {
        enable = true;
        # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      };
      xwayland.enable = true;
      dconf.enable = true;
    };
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];
    };
    security = {
      polkit.enable = true;
    };
  };
}
