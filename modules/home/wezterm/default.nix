{ config, lib, pkgs, ... }:
{
  options.Wotan.programs.wezterm.enable = lib.mkEnableOption
    "GPU-accelerated cross-platform terminal emulator and multiplexer written by @wez and implemented in Rust";

  config = lib.mkIf config.Wotan.programs.wezterm.enable {
    programs.wezterm = {
      enable = true;
      package = pkgs.wezterm;
    };
    home.file.".config/wezterm" = {
      source = ./wezterm;
      recursive = true;
    };
  };  
}
