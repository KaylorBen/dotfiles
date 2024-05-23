{ config, lib, ... }:
with lib;
let cfg = config.Wotan.programs.fzf;
in {
  options.Wotan.programs.fzf.enable =
    mkEnableOption "A command-line fuzzy finder written in Go" // {
      default = true;
    };

  config = mkIf cfg.enable {
    programs.fzf.enable = true;
  };
}

