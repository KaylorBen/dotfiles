{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.Wotan.programs.neovim;
in
{
  options.Wotan.programs.neovim = {
    enable = mkOption {
      type = types.bool;
      description = "Enable neovim";
      # Enable neovim by default
      default = true;
    };
    defaultEditor = mkOption {
      type = types.bool;
      description = "Use neovim as the default editor";
      default = true;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.nvim ];
    programs.neovim = {
      # enable = true;
      # package = pkgs.nvim;
      # extraPackages = with pkgs; [
      #   lua-language-server
      #   nil
      #   marksman
      #   gcc
      #   gnumake
      # ];
      # # for copilot
      # withNodeJs = true;
      # # package = pkgs.neovim;
      defaultEditor = cfg.defaultEditor;
    };
    # home.file.".config/nvim" = {
    #   source = ./nvim;
    #   recursive = true;
    # };
  };
}
