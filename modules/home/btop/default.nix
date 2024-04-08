{ lib, config, ... }:
{
  options.Wotan.programs.btop = {
    enable = lib.mkOption {
      type = lib.types.bool;
      description = "Htop but better";
      # Enable btop by default
      default = true;
    };
  };

  config = lib.mkIf config.Wotan.programs.btop.enable {
    home.file.".config/btop/themes/rose-pine.theme".source = ./rose-pine.theme;
    programs.btop = {
      enable = true;
      settings = {
        color_theme = "rose-pine";
        vim_keys = true;
      };
    };
  };
}
