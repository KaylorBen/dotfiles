{ config, lib, inputs, ... }:
with lib;
let cfg = config.Wotan.programs.nixcord;
in {
  options.Wotan.programs.nixcord.enable =
    mkEnableOption "Discord + Vencord config";
  config = mkIf cfg.enable {
    programs.nixcord.enable = true;
  };
}
