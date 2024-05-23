{ config, lib, ... }:
with lib;
let cfg = config.Wotan.programs.direnv;
in {
  options.Wotan.programs.direnv.enable =
    mkEnableOption "A Shell Extension that Manages Your Environment" // {
      default = true;
    };
  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      enableNushellIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
