{
  pkgs,
  ...
}:
{
  Wotan = {
    home-profiles.desktop.enable = true;
    programs.git.enable = true;
  };
  home.stateVersion = pkgs.myLib.stateVersion.home;
}
