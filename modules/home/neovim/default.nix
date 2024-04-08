{ lib, config, pkgs, ... }:
let cfg = config.Wotan.programs.neovim;
in {
  options.Wotan.programs.neovim = {
    enable = lib.mkEnableOption "Enable neovim";
    defaultEditor = lib.mkOption {
      type = lib.types.bool;
      description = "Use neovim as the default editor";
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = cfg.defaultEditor;
    };
    home.file.".config/nvim" = {
      source = ./nvim;
      recursive = true;
    };
  };
}
