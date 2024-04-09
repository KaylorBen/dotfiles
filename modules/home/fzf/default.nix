{ config, lib, ... }:
{
  options.Wotan.programs.fzf.enable =
    lib.mkEnableOption "A command-line fuzzy finder written in Go" // {
      default = true;
    };

  config = lib.mkIf config.Wotan.programs.fzf.enable {
    programs.fzf.enable = true;
  };
}

