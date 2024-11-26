{
  pkgs,
  ...
}:
{
  # Wotan.home-profiles.desktop.enable = true;
  home.stateVersion = pkgs.myLib.stateVersion.home;
  Wotan.programs.mpv.enable = true;
}
