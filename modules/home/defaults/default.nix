{ lib, config, pkgs, ... }:
let inherit (pkgs.stdenv) isDarwin;
in {
  config = {
    programs.yazi.enable = true;
    nix.settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
    home = {
      keyboard = lib.mkIf isDarwin { layout = true; };
      username = lib.mkDefault config.snowfallorg.user.name;
      homeDirectory = let inherit (config.home) username;
      in lib.mkDefault (if pkgs.stdenv.isDarwin then
        "/Users/${username}"
      else if (username != "root") then
        "/home/${username}"
      else
        "/root");
      packages = with pkgs; [ rclone ripgrep ventoy ];
      file = {
        # TODO: custom website fetch
        # ".face" = lib.mkIf (config.snowfallorg.user.name == "ben") {
        #   source = builtins.fetchurl {
        #     
        #   };
        # };
        # ".wallpaper"
        ".cargo/config" = lib.mkDefault {
          text = ''
            [alias]
            gen = "generate"

            [cargo-new]
            name = "${config.programs.git.userName}"
            email = "${config.programs.git.userEmail}"
            vcs = "git"
          '';
        };
      };
      stateVersion = lib.Wotan.stateVersion.nixos;
    };
  };
}
