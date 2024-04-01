{ lib, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];
  Wotan.autoUpgrade.enablle = true;
  environment.systemPackages = with pkgs; [ vim git ];
  Wotan.users.enable = true;
  programs.nix-ld.enable = true;

  snowfallorg.users.ben.home.config = {
    Wotan.home-profiles.server.enable = true;
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs.username = "ben";
  };

  environment.noXlibs = lib.mkForce false;
}
