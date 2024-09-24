{ config, lib, pkgs, inputs, ... }:
with lib;
let cfg = config.Wotan.styles;
in {
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
    # fonts = {
    #   serif = {
    #     package = pkgs.freefont_ttf;
    #     name = "FreeSerif";
    #   };
    #   sansSerif = {
    #     inherit (config.fonts.serif) package;
    #     name = "FreeSans";
    #   };
    #   monospace = {
    #     package = pkgs.nerdfonts.override { fonts = [ "CascadiaCode" ]; };
    #     name = "CaskaydiaCove Nerd Font";
    #   };
    #   sizes = {
    #     terminal = 18;
    #     desktop = 14;
    #     applications = 16;
    #     popups = 12;
    #   };
    # };
  };
}
