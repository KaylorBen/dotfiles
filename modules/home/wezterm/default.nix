{ config, lib, pkgs, ... }:
with lib;
let cfg = config.Wotan.programs.wezterm;
in {
  options.Wotan.programs.wezterm.enable = mkEnableOption
    "GPU-accelerated cross-platform terminal emulator and multiplexer written by @wez and implemented in Rust";

  config = mkIf cfg.enable {
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
