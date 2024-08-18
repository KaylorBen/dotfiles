{ config, lib, pkgs, ... }:
with lib;
let cfg = config.Wotan.programs.bat;
in {
  options.Wotan.programs.bat.enable =
    mkEnableOption "A cat(1) clone with wings." // {
      default = true;
    };

  config = mkIf cfg.enable {
    programs.bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        # batdiff
        batgrep
        batman
        batpipe
        batwatch
        prettybat
      ];
      config = { theme = "base16"; };
    };
  };
}

