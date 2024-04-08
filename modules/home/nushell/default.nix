{ lib, config, pkgs, ... }:
let cfg = config.Wotan.programs.nushell;
in {
  options.Wotan.programs.nushell = {
    enable = lib.mkOption {
      type = lib.types.bool;
      description = "A modern shell written in Rust";
      # Enable nushell defaults
      default = true;
    };
    carapaceCompletions = lib.mkOption {
      type = lib.types.bool;
      description = "Completion engine written in Go";
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.vivid ];
    home.file.".config/vivid/themes/rose-pine.yml".source = ./rose-pine.yml;
    programs = {
      nushell = {
        enable = true;
        package = pkgs.nushell;
        configFile.source = ./config.nu;
        envFile.source = ./env.nu;
        shellAliases = {
          "l" = "ls -l";
          "la" = "ls -a";
          "lla" = "ls -la";
          "lt" = "lsd --tree";
          "lsa" = "ls -a";
        };
      };
      carapace = {
        enable = cfg.carapaceCompletions;
        enableNushellIntegration = true;
      };
    };
  };
}
