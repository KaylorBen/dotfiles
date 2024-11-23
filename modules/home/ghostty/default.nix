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
    # programs.ghostty = {
    #   enable = true;
    #
    #   package = inputs.ghostty.packages.${system}.default;
    #
    #   settings = {
    #     font-size = 24;
    #     font-family = "FiraCode Nerd Font";
    #
    #     unfocused-split-opacity = 0.96;
    #
    #     theme = "TokyoNight";
    #   };
    # };
  };
}
