{ config, lib, pkgs, ... }:
let cfg = config.Wotan.programs.wezterm;
in {
  options.Wotan.programs.wezterm.enable = lib.mkEnableOption
    "GPU-accelerated cross-platform terminal emulator and multiplexer written by @wez and implemented in Rust";

  config = lib.mkIf cfg.enable {
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
