{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.Wotan.desktop.sway;
in
{
  options.Wotan.desktop.sway = {
    enable = lib.mkEnableOption "sway";
    extraSettings = lib.mkOption {
      type = lib.types.attrs;
      default = { };
    };
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
    };
    security.pam.services.swaylock.text = ''
      auth include login
    '';

    programs = {
      sway = {
        enable = true;
        xwayland.enable = true;
        package = pkgs.swayfx;
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
