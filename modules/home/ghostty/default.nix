{
  config,
  inputs,
  lib,
  system,
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
    home.packages = [ inputs.ghostty.packages.${system}.default ];
    home.file.".config/ghostty/config".text = ''
      theme = tokyonight

      window-decoration = false

      font-size = 32
      font-family = "FiraCode Nerd Font"
      font-family = "Noto Color Emoji"
      font-family = "Noto Sans CJK SC"
    '';

    nix.settings =
      let
        substituters = [
          "https://ghostty.chachix.org"
        ];
        trusted-public-keys = [
          "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
        ];
      in
      {
        inherit substituters trusted-public-keys;
        trusted-substituters = substituters;
        extra-trusted-public-keys = trusted-public-keys;
      };
  };
}
