{ config, lib, ...}:
with lib;
let cfg = config.Wotan.users;
in {
  options.Wotan.users.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Nebula users defaults - Opt out";
  };
  imports = [ ./perUser/root ./perUser/builder ];

  config = mkIf cfg.enable {
    # systemd.sysusers.enable = true;
    # Create groups for services
    # Audio Group

    users.groups = {
      # Audio Services (EX Jellyfin & Polaris)
      audio = { };
      # Video Services (Ex Jellyfin & Polaris)
      video = { };
      # Gamning Services (Ex Steam)
      gaming = { };
      # Virtualization Services (Ex QEMU)
      virtualization = { };
      # SSH
      ssh = { };
    };
  };
}
