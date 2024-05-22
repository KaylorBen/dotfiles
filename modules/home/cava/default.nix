{ lib, config, ... }:
let cfg = config.Wotan.programs.cava;
in {
  options.Wotan.programs.cava.enable =
    lib.mkEnableOption "Sound visualizer in terminal";

  config = lib.mkIf cfg.enable {
    programs.cava = {
      enable = true;
      settings = {
        color = {
          background = "'#191724'";
          gradient = 1;
          gradient_count = 6;
          gradient_color_1 = "'#31748f'";
          gradient_color_2 = "'#9ccfd8'";
          gradient_color_3 = "'#c4a7e7'";
          gradient_color_4 = "'#ebbcba'";
          gradient_color_5 = "'#f6c177'";
          gradient_color_6 = "'#eb6f92'";
        };
      };
    };
  };
}

