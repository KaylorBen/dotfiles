{ config, lib, ... }:
{
  config = lib.mkIf config.Wotan.users.enable {
    # Define root
    snowfallorg.users.root = { create = false; };
    users.users.root = {
      openssh.authorizedKeys.keyFiles = lib.Wotan.get-ssh-key-files "root";
      extraGroups = [ "ssh" ];
    };
  };
}
