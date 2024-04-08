{ lib, config, pkgs, ... }:
let cfg = config.Wotan.programs.neovim;
in {
  options.Wotan.programs.neovim = {
    enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enable neovim";
      # Enable neovim by default
      default = true;
    };
    defaultEditor = lib.mkOption {
      type = lib.types.bool;
      description = "Use neovim as the default editor";
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      package = pkgs.neovim;
      defaultEditor = cfg.defaultEditor;
    };
    home.file.".config/nvim" = {
      source = ./nvim;
      recursive = true;
    };
  };
}
