{ config, lib, ... }:
with lib;
let cfg = config.Wotan.programs.zathura;
in {
  options.Wotan.programs.zathura.enable =
    mkEnableOption "A highly customizable and functional document viewer";

  config = mkIf cfg.enable {
    programs.zathura = {
      enable = true;
      options = {
        default-bg = "#191724";
        default-fg = "#e0def4";

        statusbar-fg = "#e0def4";
        statusbar-bg = "#555169";

        inputbar-bg = "#6e6a86";
        inputbar-fg = "#ebbcba";

        notification-bg = "#e0def4";
        notification-fg = "#555169";

        notification-error-bg = "#f6c177";
        notification-error-fg = "#555169";

        notification-warning-bg = "#ebbcba";
        notification-warning-fg = "#555169";

        highlight-color = "#ebbcba";
        highlight-active-color = "#eb6f92";

        completion-bg = "#6e6a86";
        completion-fg = "#ebbcba";

        completion-highlighting-fg = "#26233a";
        completion-highlihgting-bg = "#ebbcba";

        recolor-lightcolor = "#191724";
        recolor-darkcolor = "#e0def4";

        recolor = false;
        recolor-keephue = false;
      };
    };
  };
}
