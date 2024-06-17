# TODO this doesnt work
{ config, lib, pkgs, ... }:
with lib;
let cfg = config.Wotan.flatpak;
in {
  options.Wotan.flatpak = {
    enable = mkEnableOption "Enable Flatpaks";
    remotes = mkOption {
      type = with types; listOf attrs;
      default = [{
        name = "flathub-beta";
        location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
      }];
    };
    lutris = mkEnableOption "Enable Lutris Flatpak";
    extraPackages = mkOption {
      type = with types; listOf attrs;
      default = [ ];
    };
  };
  config = mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config.common.default = "*";
    };
    services.flatpak = {
      enable = true;
      remotes = cfg.remotes;
      packages = cfg.extraPackages ++ (if cfg.lutris then [{
        appId = "net.lutris.Lutris";
        origin = "flathub-beta";
      }] else
        [ ]);
    };
  };
}
