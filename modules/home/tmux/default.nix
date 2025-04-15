{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.Wotan.programs.tmux;
in
{
  options.Wotan.programs.tmux.enable = mkEnableOption "Terminal multiplexer" // {
    default = true;
  };
  config = mkIf cfg.enable {
    programs.tmux = {
      sensibleOnTop = true;
      enable = true;
      shortcut = "Space";
      aggressiveResize = true;
      baseIndex = 1;
      newSession = true;
      escapeTime = 0;
      secureSocket = true;
      clock24 = true;
      terminal = "alacritty";
      mouse = true;
      historyLimit = 50000;
      plugins = with pkgs.tmuxPlugins; [
        cpu
        {
          plugin = resurrect;
          extraConfig = "set -g @resurrect-strategy-nvim 'session'";
        }
        pain-control
        battery
        {
          plugin = continuum;
          extraConfig = ''
            set -g  @continuum-restore 'on'
            set -g @continuum-save-interval '60' # minutes
          '';
        }
      ];
      extraConfig = ''
        bind-key C-Space send-prefix
        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"
        bind c new-window -c "#{pane_current_path}"
        set-option -g set-titles on
        set-option -g set-titles-string "Tmux #{online_status} #{session_name} > #{pane_title} | #h"
        set-option -sa terminal-overrides ",alacritty*:Tc"
      '';
    };
  };
}
