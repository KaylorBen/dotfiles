{ config, lib, ... }:
with lib;
let
  cfg = config.Wotan.programs.cava;
in
{
  options.Wotan.programs.cava.enable = mkEnableOption "Sound visualizer in terminal";

  config = mkIf cfg.enable {
    programs.cava = {
      enable = true;
      settings = {
        color = {
          background = "'#${config.lib.stylix.colors.base01}'";
          gradient = 1;
          gradient_count = 6;
          gradient_color_1 = "'#${config.lib.stylix.colors.base08}'";
          gradient_color_2 = "'#${config.lib.stylix.colors.base0B}'";
          gradient_color_3 = "'#${config.lib.stylix.colors.base0A}'";
          gradient_color_4 = "'#${config.lib.stylix.colors.base0D}'";
          gradient_color_5 = "'#${config.lib.stylix.colors.base0E}'";
          gradient_color_6 = "'#${config.lib.stylix.colors.base0C}'";
        };
      };
    };
  };
}
