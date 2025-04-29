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
  cfg = config.Wotan.desktop.sway;
in
{
  options.Wotan.desktop.sway = {
    enable = mkOption {
      type = types.bool;
      description = "sway";
      default = osConfig.Wotan.desktop.sway.enable or false;
    };
  };

  config = mkIf cfg.enable {
    home.file.".config/rofi/config.rasi".source = ../hyprland/rose-pine.rasi;
    home.packages = with pkgs; [
      rofi-wayland
      networkmanager
      wl-clipboard
      wl-clipboard-x11
      wlr-randr
    ];

    services.mako.enable = true;

    wayland.windowManager.sway = {
      enable = true;
      package = pkgs.swayfx;
      config = {
        bars = [ ];
      };
    };
  };
}
