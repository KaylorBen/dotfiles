{ config, lib, ... }:
with lib;
let
  cfg = config.Wotan.programs.zathura;
in
{
  options.Wotan.programs.zathura.enable = mkEnableOption "A highly customizable and functional document viewer";

  config = mkIf cfg.enable {
    programs.zathura = {
      enable = true;
    };
  };
}
