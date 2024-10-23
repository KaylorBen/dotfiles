{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
let
  cfg = config.Wotan.programs.ags;
in
  {
  options.Wotan.programs.ags = {
    enable = mkEnableOption "Ags";
  };

  imports = [ inputs.ags.homeManagerModules.default ];

  config = mkIf cfg.enable {
    programs.ags = {
      enable = true;

      # configDir = ./.;

      # extraPackages = with pkgs; [
      #
      # ];
    };
  };
}
