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
  cfg = config.Wotan.desktop.niri;
in {
  options.Wotan.desktop.niri = {
    enable = mkOption {
      type = types.bool;
      description = "niri";
      default = osConfig.Wotan.desktop.niri.enable or false;
    };
  };

  config = mkIf cfg.enable {
    home.file.".config/rofi/config.rasi".source = ../hyprland/rose-pine.rasi;
    home.file.".config/niri/config.kdl".source = ./config.kdl;
    home.packages = with pkgs; [
      rofi-wayland
      networkmanager
      wl-clipboard
      wl-clipboard-x11
      swaybg
      xwayland-satellite
    ];

    services.mako.enable = true;
    programs.waybar.enable = true;
  };
}
