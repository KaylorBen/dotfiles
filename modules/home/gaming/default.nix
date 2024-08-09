{ config, osConfig ? { }, lib, ... }:
with lib;
let cfg = config.Wotan.gaming;
in {
  options.Wotan.gaming = {
    enable = mkEnableOption "Gaming" // {
      default = osConfig.Wotan.gaming.enable or false;
    };
  };
  config = mkIf cfg.enable {
    # consider reshade
    Wotan.desktop.picom.enable = mkForce false;
    programs.mangohud = {
      enable = true;
      enableSessionWide = mkDefault true;
      settings = {
        alpha = mkForce 0.6;
        background_alpha = mkForce 0.3;
        horizontal = true;
        hud_compat = true;
        hud_no_margin = true;
        no_hud = mkDefault true;
        position = "top-center";
        horizontal_stretch = false;
        frame_timing = 0;
        time = true;
        time_no_label = true;
      };
      settingsPerApplication = {
        "wine-ffxiv_dx11" = config.programs.mangohud.settings // {
          no_hud = false;
        };
      };
    };
  };
}
