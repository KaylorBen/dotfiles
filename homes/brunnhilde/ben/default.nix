{
  lib,
  inputs,
  pkgs,
  ...
}:
{
  Wotan = {
    home-profiles.desktop.enable = true;
    programs.git.enable = true;
    desktop.hyprland.enable = true;
  };
  home.stateVersion = pkgs.myLib.stateVersion.home;
}
