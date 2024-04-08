{ config, lib, pkgs, ... }:
{
  options.Wotan.programs.alacritty.enable = lib.mkEnableOption
    "Alacritty Terminal Emulator";

  config = lib.mkIf config.Wotan.programs.alacritty.enable {
    programs.alacritty = {
      enable = true;
      package = pkgs.alacritty;
      settings = {
        colors = {
          primary = {
            foreground = "#e0def4";
            background = "#191724";
            dim_foreground = "#908caa";
            bright_foreground = "#e0def4";
          };
          cursor = {
            text = "#e0def4";
            cursor = "#524f67";
          };
          vi_mode_cursor = {
            text = "#e0def4";
            cursor = "#524f67";
          };
          search.matches = {
            foreground = "#908caa";
            background = "#26233a";
          };
          search.focused_match = {
            foreground = "#191724";
            background = "#ebbcba";
          };
          hints.start = {
            foreground = "#908caa";
            background = "#1f1d2e";
          };
          hints.end = {
            foreground = "#6e6a86";
            background = "#1f1d2e";
          };
          line_indicator = {
            foreground = "None";
            background = "None";
          };
          footer_bar = {
            foreground = "#e0def4";
            background = "#1f1d2e";
          };
          selection = {
            text = "#e0def4";
            background = "#403d52";
          };
          normal = {
            black = "#26233a";
            red = "#eb6f92";
            green = "#31748f";
            yellow = "#f6c177";
            blue = "#9ccfd8";
            magenta = "#c4a7e7";
            cyan = "#ebbcba";
            white = "#e0def4";
          };
          bright = {
            black = "#6e6a86";
            red = "#eb6f92";
            green = "#31748f";
            yellow = "#f6c177";
            blue = "#9ccfd8";
            magenta = "#c4a7e7";
            cyan = "#ebbcba";
            white = "#e0def4";
          };
          dim = {
            black = "#6e6a86";
            red = "#eb6f92";
            green = "#31748f";
            yellow = "#f6c177";
            blue = "#9ccfd8";
            magenta = "#c4a7e7";
            cyan = "#ebbcba";
            white = "#e0def4";
          };
        };
      };
    };
  };  
}
