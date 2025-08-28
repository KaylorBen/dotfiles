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
      generateCompletions = true;
      shellAliases = {
        "ls"  = mkForce "${pkgs.lsd}/bin/lsd";
        "l"   = mkForce "${pkgs.lsd}/bin/lsd -l";
        "la"  = mkForce "${pkgs.lsd}/bin/lsd -a";
        "lla" = mkForce "${pkgs.lsd}/bin/lsd -la";
        "lt"  = mkForce "${pkgs.lsd}/bin/lsd --tree";

        "gensokyo" = "${pkgs.mpg123}/bin/mpg123 https://stream.gensokyoreadio.net/1/";
      };
    };
  };
}
