{
  lib,
  inputs,
  pkgs,
  ...
}:
{
  programs.yazi.enable = true;
  Wotan = {
    home-profiles.desktop.enable = true;
    programs.git.enable = true;
    desktop.hyprland = {
      enable = true;
      extraSettings = {
        monitor = [
          "DP-1, preferred, 0x0, 1"
          "HDMI-A-1, preferred, 3840x0, 1, transform, 3"
        ];
      };
      extraAutoStart = [
        "xrandr --output DP-1 --primary"
      ];
      plugins = with pkgs.hyprlandPlugins; [
        inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
      ];
      splitBinds = true;
      bar = "ags";
    };
  };
  home.stateVersion = pkgs.myLib.stateVersion.home;
}
