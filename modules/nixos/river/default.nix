{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.Wotan.desktop.river;
in
{
  options.Wotan.desktop.river = {
    enable = lib.mkEnableOption "river";
  };

  config = lib.mkIf cfg.enable {
    programs.light.enable = true;
    services = {
      greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time";
            user = "greeter";
          };
        };
      };
    };
    security.pam.services.swaylock.text = ''
      auth include login
    '';

    programs = {
      river = {
        enable = true;
        xwayland.enable = true;
      };
      dconf.enable = true;
    };
    xdg.portal = {
      wlr.enable = true;
    };
    security = {
      polkit.enable = true;
    };
  };
}
