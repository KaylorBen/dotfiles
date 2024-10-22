{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.Wotan.programs.btop;
in
{
  options.Wotan.programs.btop = {
    enable = mkOption {
      type = types.bool;
      description = "Htop but better";
      # Enable btop by default
      default = true;
    };
  };

  config = mkIf cfg.enable {
    # home.file.".config/btop/themes/rose-pine.theme".source = ./rose-pine.theme;
    programs.btop = {
      enable = true;
      package = (pkgs.btop.override { cudaSupport = true; });
      settings = {
        # color_theme = "rose-pine";
        truecolor = true;
        vim_keys = true;
      };
    };
  };
}
