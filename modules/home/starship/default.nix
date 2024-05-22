{ lib, config, ... }:
let cfg = config.Wotan.programs.starship;
in {
  options.Wotan.programs.starship.enable =
    lib.mkEnableOption "Terminal theming application" // {
      default = true;
    };
  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
      settings = {
        add_newline = lib.mkDefault false;
        battery = lib.mkDefault {
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
          show_always = lib.mkDefault true;
          style_user = lib.mkDefault "bold green";
          style_root = lib.mkDefault "bold red";
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

