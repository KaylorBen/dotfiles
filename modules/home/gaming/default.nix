{ lib, config, osConfig ? { }, ... }:
{
  options.Wotan.gaming = {
    enable = lib.mkEnableOption "Gaming" // {
      default = osConfig.Wotan.gaming.enable or false;
    };
  };
  config = lib.mkIf config.Wotan.gaming.enable {
    # consider reshade
    programs.mangohud = {
      enable = true;
      enableSessionWide = lib.mkDefault true;
      settings = {
        alpha = lib.mkForce 0.6;
        background_alpha = lib.mkForce 0.3;
        horizontal = true;
        hud_compat = true;
        hud_no_margin = true;
        no_hud = lib.mkDefault true;
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
