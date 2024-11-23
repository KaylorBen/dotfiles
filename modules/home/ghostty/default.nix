{
  config,
  inputs,
  lib,
  system,
  ...
}:
let
  cfg = config.Wotan.ghostty;
  inherit (lib)
    mkEnableOption
    mkIf
    ;
in
{
  options.Wotan.ghostty.enable = mkEnableOption "Ghostty";

  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true;

      package = inputs.ghostty.packages.${system}.default;

      settings = {
        font-size = 24;
        font-family = "FiraCode Nerd Font";

        unfocused-split-opacity = 0.96;

        theme = "TokyoNight";
      };
    };
  };
}
