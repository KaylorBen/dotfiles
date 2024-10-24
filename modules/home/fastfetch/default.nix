{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.Wotan.programs.ags;
in
{
  options.Wotan.programs.fastfetch = {
    enable = mkEnableOption "fastfetch";
  };

  config = mkIf cfg.enable {
    programs.fastfetch = {
      enable = true;

      settings = {
        logo.source = "${lib.Wotan.get-asset "ffxiv.png"}";
        display = {
          color = "dim_red";
          seperator = "  ";
        };
      };
    };
  };
}
