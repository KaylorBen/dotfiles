{
  # awesomewm options
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    videoDrivers = [ "nvidia" ];
    xrandrHeads =
    [
      {
        output = "HDMI-0";
        monitorConfig =
        ''
          Option "Rotate" "left"
          Option "LeftOf" "DP-0"
        '';
      }
      {
        output = "DP-0";
        primary = true;
        monitorConfig =
        ''
          Option "RightOf" "HDMI-0"
        '';
      }
    ];
    # displayManager.setupCommands = ""
    displayManager = {
      lightdm.enable = true;
      defaultSession = "none+awesome";
    };
    windowManager.awesome.enable = true;
  };
}
