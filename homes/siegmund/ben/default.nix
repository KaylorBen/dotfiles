{
  config,
  inputs,
  pkgs,
  ...
}:
let
  mkIf = pkgs.lib.mkIf;
in
{
  Wotan = {
    home-profiles.desktop.enable = true;
    programs.git.enable = true;
  };
  # // (mkIf config.Wotan.desktop.hyprland.enable {
  #   desktop.hyprland = {
  #     enable = true;
  #     extraSettings = {
  #       monitor = [
  #         "DP-1, preferred, 3840x0, 1"
  #         "HDMI-A-1, 3480x2160@120.0, 0x0, 1"
  #       ];
  #     };
  #     extraAutoStart = [
  #       "xrandr --output HDMI-A-1 --primary --pos 0x0"
  #     ];
  #     plugins = with pkgs.hyprlandPlugins; [
  #       inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
  #     ];
  #     splitBinds = true;
  #     bar = "ags";
  #   };
  # })
  # // (mkIf config.Wotan.desktop.sway.enable {
  #   desktop.sway = {
  #     enable = true;
  #     extraSettings = {
  #       output = {
  #         DP-1 = {
  #           mode = "3840x2160@64.00Hz";
  #           pos = "3840 0";
  #         };
  #         HDMI-A-1 = {
  #           mode = "3840x2160@120.00Hz";
  #           pos = "0 0";
  #         };
  #       };
  #     };
  #   };
  # });
  home.stateVersion = pkgs.myLib.stateVersion.home;
}
