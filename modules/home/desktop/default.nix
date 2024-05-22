{ config, pkgs, lib, ... }:
let cfg = config.Wotan.home-profiles.desktop;
in {
  options.Wotan.home-profiles.desktop = {
    enable = lib.mkEnableOption "Enable desktop defaults";
  };
  config = lib.mkIf cfg.enable {
    Wotan = {
      programs = {
        chromium.enable = true;
        firefox.enable = true;
        alacritty.enable = true;
        zathura.enable = true;
        cava.enable = true;
        mpv.enable = true;
        ssh.enable = true;
      };
    };
    services.syncthing.enable = true;

    gtk = {
      font.size = lib.mkDefault 12;
      iconTheme = {
        name = "rose-pine";
        package = pkgs.rose-pine-icon-theme;
      };
      theme = {
        name = "rose-pine";
        package = pkgs.rose-pine-gtk-theme;
      };
    };

    # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
    xdg.configFile = {
      "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
      "gtk-3.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-3.0/assets";
      "gtk-3.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    };

    home = {
      sessionVariables = {
        DONTNET_CLI_TELEMETRY_OPTOUT = "1";
        DOTNET_ROOT = "${pkgs.dotnet-sdk}";
        DOTNET_SKIP_FIRST_TIME_EXPERIENCE = "1";
        TERM = "alacritty";
      };
      sessionPath = [ "${pkgs.dotnet-sdk}/bin" "~/.local/bin" "~/.cargo/bin" ];
      keyboard.layout = true;
      packages = with pkgs; [
        audacity
        emulsion
        discord
        freetube
        ffmpeg_5-full
        # kitty
        libreoffice
        pavucontrol
        pinta
        spotify-player
        teamspeak_client
        todo
        vesktop
        youtube-tui
      ];
    };
    services.easyeffects.enable = true;
    fonts.fontconfig.enable = true;
  };
}
