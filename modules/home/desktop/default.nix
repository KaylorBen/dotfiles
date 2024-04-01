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
        kitty.enable = true;
        mpv.enable = true;
        ssh.enable = true;
      };
    };
    services.syncthings.enable = true;

    gtk.font.size = lib.mkDefault 12;

    home = {
      sessionVariables = {
        DONTNET_CLI_TELEMETRY_OPTOUT = "1";
        DOTNET_ROOT = "${pkgs.dotnet-sdk}";
        DOTNET_SKIP_FIRST_TIME_EXPERIENCE = "1";
        TERM = "kitty";
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
