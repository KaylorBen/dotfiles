{ lib, config, pkgs, ... }:
let cfg = config.Wotan.programs.git;
in {
  options.Wotan.programs.git.enable =
    lib.mkEnableOption "Distributed version control system" // {
      default = true;
    };
  config = lib.mkIf cfg.enable {
    programs.git = {
      package = pkgs.gitAndTools.gitFull;
      enable = true;
      userName = "Benjamin Kaylor";
      userEmail = "blkaylor22@gmail.com";
      delta.enable = true;
      lfs = { enable = true; };
      ignores = [ "*~" "*.swp" ".DS_Store" ];
      extraConfig = {
        init.defaultBranch = "main";
        core = { whitespace = "trailing-space,space-before-tab"; };
        safe.directory = "/etc/nixos";
      };
      # signing = {
      #   signByDefault = config.programs.gpg.enable;
      # } // mkIf (!config.Wotan.programs._1password.gpgSign.enable) {
      #   key = "";
      # };
    };
  };
}

