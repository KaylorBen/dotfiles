{ config, lib, ... }:
{
  options.Wotan.programs.wezterm.enable = lib.mkEnableOption
    "GPU-accelerated cross-platform terminal emulator and multiplexer written by @wez and implemented in Rust";

  config = lib.mkIf config.Wotan.programs.wezterm.enable {
    programs.wezterm = {
      enable = true;
      extraConfig = ''
        return {
          hide_tab_bar_if_only_one_tab = true,
        }
      '';
    };
  };  
}
