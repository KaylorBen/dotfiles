{ config, lib, pkgs, ... }:
with lib;
let cfg = config.Wotan.programs.nushell;
in {
  options.Wotan.programs.nushell = {
    enable = mkOption {
      type = types.bool;
      description = "A modern shell written in Rust";
      # Enable nushell defaults
      default = true;
    };
    carapaceCompletions = mkOption {
      type = types.bool;
      description = "Completion engine written in Go";
      default = true;
    };
  };

  config = mkIf cfg.enable {
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
          "windows" = "quickemu --vm /home/ben/VMs/windows/windows-11.conf";
        };
      };
      carapace = {
        enable = cfg.carapaceCompletions;
        enableNushellIntegration = true;
      };
      lsd.enable = true; # For tree command
    };
  };
}
