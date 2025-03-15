{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with lib;
let
  cfg = config.Wotan.foundry;
in
{
  options.Wotan.foundry = {
    enable = mkEnableOption "Enable Foundry Virtual Tabletop Server";
  };

  config = mkIf cfg.enable {
    services.foundryvtt = {
      enable = true;
    };
  };
}
