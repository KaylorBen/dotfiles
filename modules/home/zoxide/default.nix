{ lib, config, ... }:
{
  options.Wotan.programs.zoxide.enable =
    lib.mkEnableOption "Terminal navigation tool" // {
      default = true;
    };
  config = lib.mkIf config.Wotan.programs.zoxide.enable {
    programs.zoxide = {
      enable = true;
      enableNushellIntegration = true;
      options = [ "--cmd cd" ];
    };
  };
}
