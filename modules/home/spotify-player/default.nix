{ config, lib, ... }:
with lib;
let cfg = config.Wotan.programs.spotify-player;
in {
  options.Wotan.programs.ssh.enable = mkEnableOption "Spotify Player";

  config = mkIf cfg.enable {
    programs.spotify-player = {
      enable = true;
      keymaps = [
        {
          command = "NextTrack";
          key_sequence = "g n";
        }
        {
          command = "PreviousTrack";
          key_sequence = "g p";
        }
        {
          command = "PageSelectNextOrScrollDown";
          key_sequence = "C-d";
        }
        {
          command = "PageSelectPreviousOrScrollUp";
          key_sequence = "C-u";
        }
      ];
    };
  };
}
