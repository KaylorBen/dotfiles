{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  inherit (pkgs.stdenv) isDarwin;
in
{
  config = {
    programs = {
      yazi.enable = true;
    };
    nix.settings =
      let
      in
      # substituters = [
      #   "https://nix-community.cachix.org"
      # ];
      # trusted-public-keys = [
      #   "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      # ];
      {
        # inherit substituters trusted-public-keys;
        # trusted-substituters = substituters;
        # extra-trusted-public-keys = trusted-public-keys;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
    home = {
      keyboard = mkIf isDarwin { layout = true; };
      username = mkDefault "ben";
      homeDirectory =
        let
          inherit (config.home) username;
        in
        mkDefault (
          if pkgs.stdenv.isDarwin then
            "/Users/${username}"
          else if (username != "root") then
            "/home/${username}"
          else
            "/root"
        );
      packages = with pkgs; [
        comma
        rclone
        ripgrep
        ventoy
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
      stateVersion = pkgs.myLib.stateVersion.nixos;
    };
  };
}
