{ config, pkgs, lib, ... }:
{
  options.Wotan.home-profiles.desktop = {
    enable = lib.mkEnableOption "Enable desktop defaults";
  };
  config = lib.mkIf config.Wotan.home-profiles.desktop.enable {
    Wotan = {
      programs = {
        chromium.enable = true;
        firefox.enable = true;
        wezterm.enable = true;
        mpv.enable = true;
        ssh.enable = true;
      };
    };
    services.syncthing.enable = true;

    gtk.font.size = lib.mkDefault 12;

    home = {
      sessionVariables = {
        DONTNET_CLI_TELEMETRY_OPTOUT = "1";
        DOTNET_ROOT = "${pkgs.dotnet-sdk}";
        DOTNET_SKIP_FIRST_TIME_EXPERIENCE = "1";
        TERM = "wezterm";
      };
      sessionPath = [ "${pkgs.dotnet-sdk}/bin" "~/.local/bin" "~/.cargo/bin" ];
      keyboard.layout = true;
      packages = with pkgs; [
        audacity
        freetube
        vesktop
      ];
    };
    fonts.fontconfig.enable = true;
  };
}