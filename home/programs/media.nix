{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # audio
    pa_applet
    spotify-player

    # image
    alchemy # drawing application -- very artistic/no undo
    artem # Convert images from multiple formats to ASCII art
    emulsion  # lightweight image viewer
    imgcat  # display images in the terminal
    kcc # kindle comic converter
    lorien  # note scratchpad and drawing app
    gimp  # GNU Image Manipulation Program
    pinta # effective paint alternative

    # video
    vlc # Cross-platform multimedia player and streaming server
    ffmpeg # Converter and other stuff required
  ];

  programs = {
    mpv = {
      enable = true;
      defaultProfiles = ["gpu-hq"];
      scripts = [pkgs.mpvScripts.mpris];
    };

    yt-dlp = {
      enable = true;
      settings = {
        embed-subs = true;
        format = "bv+ba/b";
        exec = "mpv";
        sponsorblock-api = "https://sponsor.ajay.app";
        mark-watched = true;
      };
      extraConfig = ''
        --exec rm
      '';
    };

    obs-studio.enable = true;
  };

  services = {
    grobi = { # Automatically configure monitors/outputs for Xorg via RandR
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
    flameshot = { # Powerful yet simple to use screenshot software
      enable = true;
      settings = {
        General = {
          disabledTrayIcon = true;
          showStartupLaunchMessage = false;
          uiColor = "#000000";
        };
      };
    };
    easyeffects.enable = true;
  };
}
