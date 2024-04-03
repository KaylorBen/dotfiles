{ config, lib, ... }:
{
  config = lib.mkIf config.Wotan.users.enable {
    users = {
      groups.builder = { };
      users.builder = {
        openssh.authorizedKeys.keyFiles =
          config.users.users.root.openssh.authorizedKeys.keyFiles;
        group = "builder";
        extraGroups = [ "ssh" ];
        createHome = false;
        isSystemUser = true;
        useDefaultShell = true;
        description = "NixOS builder";
      };
    };
  };
}
