{ lib, config, ... }:
let cfg = config.Wotan.programs.zoxide;
in {
  options.Wotan.programs.zoxide.enable =
    lib.mkEnableOption "Terminal navigation tool" // {
      default = true;
    };
  config = lib.mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableNushellIntegration = true;
      options = [ "--cmd cd" ];
    };
  };
}
