{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.Wotan.programs.eww;
  inherit (lib)
    mkEnableOption
    mkIf
    ;
in
{
  options.Wotan.programs.eww.enable = mkEnableOption "Widgets _SWAY_ONLY_";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      alsa-utils
      swaysome
      wireplumber
      playerctl
      mpc
      jq
      vimpc
    ];
    programs.eww = {
      enable = true;
    };
    # too lazy to put this in its own thing
  };
}
