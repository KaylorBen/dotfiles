{ lib, config, pkgs, ... }:
let cfg = config.Wotan.programs.mpv;
in {
  options.Wotan.programs.mpv.enable =
    lib.mkEnableOption "General-purpose media player, fork of MPlayer and mplayer2";
  config = lib.mkIf cfg.enable {
    programs.mpv = {
      enable = true;
      package = pkgs.mpv;
      scripts = with pkgs.mpvScripts; [
        sponsorblock
        webtorrent-mpv-hook
        vr-reversal
        visualizer
        thumbnail
        quality-menu
        mpv-playlistmanager
      ];
      config = {
        profile = "gpu-hq";
        ytdl-format = "bestvideo+bestaudio";
      };
    };
  };
}
