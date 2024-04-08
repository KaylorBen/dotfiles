{ lib, config, ... }:
{
  options.Wotan.programs.starship.enable =
    lib.mkEnableOption "Terminal theming application" // {
      default = true;
    };
  config = lib.mkIf config.Wotan.programs.starship.enable {
    programs.starship = {
      enable = true;
      enableNushellIntegration = true;
    };

    home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";
  };
}

