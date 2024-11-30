{ config, lib, ... }:
{
  config = lib.mkIf config.Wotan.users.enable {
    # Define root
    users.users.root = {
      # openssh.authorizedKeys.keyFiles = lib.Wotan.get-ssh-key-files "root";
      # initialPassword = "NixOS4Life";
      extraGroups = [ "ssh" ];
    };
  };
}
