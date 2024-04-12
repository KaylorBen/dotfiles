# TODO this doesnt work
{config, lib, pkgs, ...}:
let cfg = config.Wotan.flatpak;
in {
  options.Wotan.flatpak = {
    enable = lib.mkEnableOption "Enable Flatpaks";
    remotes = lib.mkOption {
      type = with lib.types; listOf attrs;
      default = [{
        name = "flathub-beta";
        location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
      }];
    };
    lutris = lib.mkEnableOption "Enable Lutris Flatpak";
    extraPackages = lib.mkOption {
      type = with lib.types; listOf attrs;
      default = [ ];
    };
  };
  config = lib.mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config.common.default = "*";
    };
    services.flatpak = {
      enable = true;
      remotes = cfg.remotes;
      packages = cfg.extraPackages
        ++ (if cfg.lutris then
          [ { appId = "net.lutris.Lutris"; origin = "flathub-beta"; } ]
          else [ ]
        );
    };
  };
}
