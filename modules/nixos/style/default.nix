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
    enable = mkEnableOption {
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

      base16Scheme = "${pkgs.base16-schemes}/share/themes/${cfg.style}.yaml";

      fonts = {
        serif = {
          package = pkgs.fonts;
          name = "FiraCode";
        };
        sansSerif = {
          package = pkgs.fonts;
          name = "FantasqueSansMono";
        };
        monospace = {
          package = pkgs.fonts;
          name = "FiraMono";
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
      };

      opacity.terminal = 0.6;
    };
  };
}
