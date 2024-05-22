{ lib, config, ... }:
let cfg = config.Wotan.programs.direnv;
in {
  options.Wotan.programs.direnv.enable =
    lib.mkEnableOption "A Shell Extension that Manages Your Environment" // {
      default = true;
    };
  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      enableNushellIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
