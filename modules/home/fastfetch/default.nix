{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.Wotan.programs.ags;
in
{
  options.Wotan.programs.fastfetch = {
    enable = mkEnableOption "fastfetch";
  };

  config = mkIf cfg.enable {
    programs.fastfetch = {
      enable = true;

      settings = {
        logo = {
          source = "${pkgs.myLib.get-asset "ffxiv.png"}";
          height = 18;
          padding.top = 1;
          padding.right = 1;
        };
        display = {
          size.binaryPrefix = "si";
          color = "bright_magenta";
          separator = "  ";
        };

        modules = [
          "title"
          "separator"
          "os"
          "host"
          {
            type = "kernel";
            format = "{release}";
          }
          "uptime"
          "shell"
          "terminal"
          {
            type = "display";
            compactType = "original";
            key = "Resolution";
          }
          "wm"
          "wmtheme"
          "theme"
          "icons"
          {
            type = "terminalfont";
            fromat = "{/name}{-}{/}{name}{?size} {size}{?}";
          }
          "cpu"
          {
            type = "gpu";
            key = "GPU";
          }
          {
            type = "memory";
            format = "{} / {}";
          }
          "break"
          "colors"
        ];
      };
    };
  };
}
