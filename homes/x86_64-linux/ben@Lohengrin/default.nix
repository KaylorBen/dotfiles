{ lib, inputs, config, ... }: {
  # Wotan.home-profiles.desktop.enable = true;
  home.stateVersion = lib.Wotan.stateVersion.home;
  Wotan.programs.mpv.enable = true;
}
