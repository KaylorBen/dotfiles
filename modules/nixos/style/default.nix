{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.Wotan.styles;
in
{
  options.Wotan.styles = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "styles";
    };
    style = mkOption {
      type = types.str;
      default = "rose-pine";
    };
  };

  config = mkIf cfg.enable {
    stylix = {
      enable = true;

      image = ./../../home/awesome/awesome/themes/rose-pine/wallpaper_primary.jpg;

      base16Scheme = "${pkgs.base16-schemes}/share/themes/${cfg.style}.yaml";

      cursor = {
        package = pkgs.rose-pine-cursor;
        name = "BreezeX-RosePine-Linux";
      };

      fonts = {
        serif = {
          package = pkgs.fonts;
          name = "FiraCode Nerd Font";
        };
        sansSerif = {
          package = pkgs.fonts;
          name = "FiraCode Nerd Font";
        };
        monospace = {
          package = pkgs.fonts;
          name = "FiraCode Nerd Font";
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
      };

      opacity.terminal = 0.95;
    };
  };
}
