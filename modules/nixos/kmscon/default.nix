{config, lib, pkgs, ...}:
let
  cfg = config.Wotan.kmscon;
in {
  options.Wotan.kmscon = {
    enable = lib.mkEnableOption "kmscon TTY interface";
    fonts = lib.mkOption {
      type = with lib.types; listOf attrs;
      default = [ {
        name = "FiraMono Nerd Font";
        package = pkgs.nerdfonts;
      } ];
    };
  };

  config = lib.mkIf cfg.enable {
    services.kmscon = {
      enable = true;
      hwRender = true;
      fonts = cfg.fonts;
    };
  };
}
