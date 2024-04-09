{ config, lib, pkgs, ... }:
{
  options.Wotan.programs.bat.enable = lib.mkEnableOption "A cat(1) clone with wings."
    // {
      default = true;
    };

  config = lib.mkIf config.Wotan.programs.bat.enable {
    programs.bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batdiff
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

