{
  config,
  lib,
  pkgs,
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

  config = mkIf cfg.enable {
    programs.ags = {
      enable = true;

      configDir = ./.;

      extraPackages = with pkgs; [

      ];
    };
  };
}
