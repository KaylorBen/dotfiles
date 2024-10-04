{ config, lib, pkgs, ... }:
with lib;
let inherit (pkgs.stdenv) isDarwin;
in {
  config = {
    programs = {
      yazi.enable = true;
    };
    nix.settings = { experimental-features = [ "nix-command" "flakes" ]; };
    home = {
      keyboard = mkIf isDarwin { layout = true; };
      username = mkDefault config.snowfallorg.user.name;
      homeDirectory = let inherit (config.home) username;
      in mkDefault (if pkgs.stdenv.isDarwin then
        "/Users/${username}"
      else if (username != "root") then
        "/home/${username}"
      else
        "/root");
      packages = with pkgs; [
        rclone
        ripgrep
        ventoy
        smassh
      ];
      file = {
        # TODO: custom website fetch
        # ".face" = mkIf (config.snowfallorg.user.name == "ben") {
        #   source = builtins.fetchurl {
        #
        #   };
        # };
        # ".wallpaper"
        # ".cargo/config" = mkDefault {
        #   text = ''
        #     [alias]
        #     gen = "generate"
        #
        #     [cargo-new]
        #     name = "${config.programs.git.userName}"
        #     email = "${config.programs.git.userEmail}"
        #     vcs = "git"
        #   '';
        # };
      };
      stateVersion = Wotan.stateVersion.nixos;
    };
  };
}
