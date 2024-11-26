{
  lib,
  inputs,
  config,
  ...
}:
{
  Wotan.home-profiles.desktop.enable = true;
  home.stateVersion = lib.stateVersion.home;
}
