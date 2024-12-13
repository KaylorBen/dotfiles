{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.Wotan.programs.ghostty;
  inherit (lib)
    mkEnableOption
    mkIf
    ;
in
{
  options.Wotan.programs.ghostty.enable = mkEnableOption "Ghostty";

  config = mkIf cfg.enable {
    home.packages = [ inputs.ghostty.packages.${pkgs.system}.default ];
    home.file.".config/ghostty/config".text = ''
      theme = tokyonight

      window-decoration = false
      gtk-titlebar = false

      font-size = 32
      font-family = "FiraCode Nerd Font"
      font-family = "Noto Color Emoji"
      font-family = "Noto Sans CJK SC"
    '';
  };
}
