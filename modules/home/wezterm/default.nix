{ config, lib, inputs, pkgs, ... }:
{
  options.Wotan.programs.wezterm.enable = lib.mkEnableOption
    "GPU-accelerated cross-platform terminal emulator and multiplexer written by @wez and implemented in Rust";

  config = lib.mkIf config.Wotan.programs.wezterm.enable {
    programs.wezterm = {
      enable = true;
      package = pkgs.wezterm;
      extraConfig = ''
        return {
          enable_wayland = false,
          hide_tab_bar_if_only_one_tab = true,
        }
      '';
    };
  };  
}
