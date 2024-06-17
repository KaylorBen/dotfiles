{ config, lib, ... }:
with lib;
let cfg = config.Wotan.programs.zoxide;
in {
  options.Wotan.programs.zoxide.enable =
    mkEnableOption "Terminal navigation tool" // {
      default = true;
    };
  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableNushellIntegration = true;
      options = [ "--cmd cd" ];
    };
  };
}
