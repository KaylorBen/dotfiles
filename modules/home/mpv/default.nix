{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.Wotan.programs.mpv;
in
{
  options.Wotan.programs.mpv.enable =
    mkEnableOption "General-purpose media player, fork of MPlayer and mplayer2";
  config = mkIf cfg.enable {
    programs.mpv = {
      enable = true;
      package = pkgs.mpv;
      scripts = with pkgs.mpvScripts; [
        sponsorblock
        webtorrent-mpv-hook
        vr-reversal
        # visualizer
        thumbnail
        quality-menu
        mpv-playlistmanager
        (pkgs.mpvScripts.buildLua {
          pname = "mpv-copyStuff";
          version = "0-unstable-something";

          src = pkgs.fetchFromGitHub {
            owner = "rofe33";
            repo = "mpv-copyStuff";
            rev = "357f34c60b2838346120612db10da7b0fd1d6850";
            hash = "sha256-oOBA3kRR6oq1rGk9nR+j0hw7DVAdkuhyT54ZIhdWXGA=";
          };
        })
      ];
      config = {
        profile = "gpu-hq";
        ytdl-format = "bestvideo+bestaudio";
        osc = "no";
      };
    };
  };
}
