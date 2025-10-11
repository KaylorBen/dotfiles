{
  config,
  lib,
  pkgs,
  osConfig,
  ...
}:
let
  inherit (lib)
    mkOption
    mkIf
    types
    ;
  cfg = config.Wotan.desktop.river;
in
{
  options.Wotan.desktop.river = {
    enable = mkOption {
      type = types.bool;
      description = "river";
      default = osConfig.Wotan.desktop.river.enable or false;
    };
  };

  config = mkIf cfg.enable {
    home.file.".config/rofi/config.rasi".source = ../hyprland/rose-pine.rasi;
    home.packages = with pkgs; [
      rofi
      networkmanager
      wl-clipboard
      wl-clipboard-x11
      i3bar-river
      wlr-randr
    ];

    services.mako.enable = true;
  };
}
