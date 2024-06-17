{ config, lib, pkgs, ... }:
with lib;
let cfg = config.Wotan.kmscon;
in {
  options.Wotan.kmscon = {
    enable = mkEnableOption "kmscon TTY interface";
    fonts = mkOption {
      type = with types; listOf attrs;
      default = [{
        name = "FiraMono Nerd Font";
        package = pkgs.nerdfonts;
      }];
    };
  };

  config = mkIf cfg.enable {
    services.kmscon = {
      enable = true;
      hwRender = true;
      fonts = cfg.fonts;
    };
  };
}
