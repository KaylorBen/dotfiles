{ config, lib, ... }:
let cfg = config.Wotan.users;
in {
  config = lib.mkIf cfg.enable {
    users = {
      groups.builder = { };
      users.builder = {
        openssh.authorizedKeys.keyFiles =
          config.users.users.root.openssh.autorizedKeys.keyFiles;
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
