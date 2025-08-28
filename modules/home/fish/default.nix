{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.Wotan.programs.fish;
in
{
  options.Wotan.programs.fish.enable = mkEnableOption "User friendly shell" // {
    default = true;
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      shellAliases = {
        "ls"  = "${pkgs.lsd}/bin/lsd";
        "l"   = "${pkgs.lsd}/bin/lsd -l";
        "la"  = "${pkgs.lsd}/bin/lsd -a";
        "lla" = "${pkgs.lsd}/bin/lsd -la";
        "lt"  = "${pkgs.lsd}/bin/lsd --tree";

        "gensokyo" = "${pkgs.mpg123}/bin/mpg123 https://stream.gensokyoreadio.net/1/";
      };
    };
  };
}
