{  config, lib, ... }:
with lib;
let cfg = config.Wotan.programs.starship;
in {
  options.Wotan.programs.starship.enable =
    mkEnableOption "Terminal theming application" // {
      default = true;
    };
  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      settings = {
        add_newline = mkDefault false;
        battery = mkDefault {
          full_symbol = "🔋";
          charging_symbol = "⚡️";
          discharging_symbol = "💀";
          display = [
            {
              threshold = 10;
              style = "bold red";
            }
            {
              threshold = 30;
              style = "bold yellow";
            }
          ];
        };
        username = {
          show_always = mkDefault true;
          style_user = mkDefault "bold green";
          style_root = mkDefault "bold red";
        };
        directory = {
          substitutions = {
            "Documents" = "󰈙 ";
            "Downloads" = " ";
            "Music" = " ";
            "Pictures" = " ";
          };
        };
      };
      enableNushellIntegration = true;
    };

    home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";
  };
}

