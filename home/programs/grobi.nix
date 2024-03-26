{
  services.grobi = { # Automatically configure monitors/outputs for Xorg via RandR
    enable = true;
    rules = [
      {
        name = "Default";
        outputs_connected = [ "DP-0" "HDMI-0" ];
        configure_row = [
          "HDMI-0"
          "DP-0"
        ];
      }
    ];
  };
}
