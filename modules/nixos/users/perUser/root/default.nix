{ config, lib, pkgs, ... }:
let cfg = config.Wotan.users;
in {
  config = lib.mkIf cfg.enable {
    # Define root
    snowfallorg.users.root = { create = false; };
    users.users.root = {
      openssh.authorizedKeys.keyFiles = lib.Wotan.get-ssh-key-files "root";
      extraGroups = [ "ssh" ];
    };
  };
}
