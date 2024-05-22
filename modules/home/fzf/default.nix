{ config, lib, ... }:
let cfg = config.Wotan.programs.fzf;
in {
  options.Wotan.programs.fzf.enable =
    lib.mkEnableOption "A command-line fuzzy finder written in Go" // {
      default = true;
    };

  config = lib.mkIf cfg.enable {
    programs.fzf.enable = true;
  };
}

