{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.Wotan.programs.eww;
  inherit (lib)
    mkEnableOption
    mkIf
    ;
in
{
  options.Wotan.programs.eww.enable = mkEnableOption "Widgets";
  config = mkIf cfg.enable {
    programs.eww = {
      enable = true;
    };
  };
}
