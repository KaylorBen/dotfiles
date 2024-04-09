{ lib, config, ... }:
{
  options.Wotan.programs.direnv.enable =
    lib.mkEnableOption "A Shell Extension that Manages Your Environment" // {
      default = true;
    };
  config = lib.mkIf config.Wotan.programs.direnv.enable {
    programs.direnv = {
      enable = true;
      enableNushellIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
