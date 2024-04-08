{ config, pkgs, lib, ... }:
let
  cfg = config.Wotan.impermanence;
  dir = directory: user: group: mode: { inherit directory user group mode; };
in {
  options.Wotan.impermanence = {
    enable = lib.mkEnableOption "impermanence";
    rollbackCommand = lib.mkOption {
      type = lib.types.str;
      description = "Command to remove all impermanent files";
    };
    persistentDirectory = lib.mkOption {
      type = lib.types.str;
      description = "Directory to store persistent files";
      default = "/.persistent";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      # Handles rollbacks for ZFS, disabled to ensure paths are fully set
      boot.initrd.systemd.services.impermanence = {
        description = "Resets root to a clean state (Requires ZFS)";
        wantedBy = [ "initrd.target" ];
        after = [ "zfs-import-zroot.service" ];
        before = [ "sysroot.mount" ];
        path = with pkgs; [ zfs ];
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script = cfg.rollbackCommand;
      };
      fileSystems.${cfg.persistentDirectory}.neededForBoot = true;
      environment.persistence.${cfg.persistentDirectory} = {
        hideMounts = true;
        directories = [
          (dir "/var/log" "root" "root" "u=rwx,g=rx,o=rx")
          (dir "/var/lib/bluetooth" "root" "root" "u=rwx,g=,o=")
          (dir "/var/lib/nixos" "root" "root" "u=rwx,g=rx,o=rx")
          (dir "/var/lib/systemd/coredump" "root" "root" "u=rwx,g=rx,o=rx")
          (dir "/etc/NetworkManager/system-connections" "root" "root"
            "u=rwx,g=,o=")
          "/var/lib/flatpak"
          "/var/lib/libvirt"
          "/var/lib/pipewire"
          (dir "/var/lib/alsa" "root" "root" "u=rwx,g=rx,o=rx")
          (dir "/var/cache/tailscale" "root" "root" "u=rwx,g=rx,o=rx")

          (dir "/var/lib/tailscale" "root" "root" "u=rwx,g=,o=")
          (dir "/var/db/sudo" "root" "root" "u=rwx,g=,o=")
          (dir "/etc/secureboot" "root" "root" "u=rwx,g=rx,o=rx")
          (dir "/etc/fwupd" "root" "root" "u=rwx,g=rx,o=rx")
          (dir "/etc/ssh/authorized_keys.d" "root" "root" "u=rwx,g=rx,o=rx")
          (dir "/var/lib/colord" "colord" "colord" "u=rwx,g=rx,o=rx")
        ];
        files = [
          "/etc/machine-id"
          {
            file = "/etc/nix/id_rsa";
            parentDirectory = { mode = "u=rwx,g=,o="; };
          }
          "/etc/adjtime"
          "/etc/ssh/ssh_host_ed25519_key"
          "/etc/ssh/ssh_host_ed25519_key.pub"
          "/etc/ssh/ssh_host_rsa_key"
          "/etc/ssh/ssh_host_rsa_key.pub"
        ];
      };
    }
    (lib.mkIf config.Wotan.users.enable {
      users.users.root.hashedPasswordFile = "/.persistent/passwords/root";
      users.users.ben.hashedPasswordFile = "/.persistent/passwords/ben";
      programs.fuse.userAllowOther = true;
      environment.persistence.${cfg.persistentDirectory} = {
        users.ben = {
          directories = [
            "Downloads"
            "Music"
            "Games"
            ".xlcore"
            "Pictures"
            "Documents"
            "Videos"
            "VirtualBox VMs"
            "Development"
            {
              directory = ".gnupg";
              mode = "0700";
            }
            {
              directory = ".ssh";
              mode = "0700";
            }
            {
              directory = ".local/share/keyrings";
              mode = "0700";
            }
            ".local/share/direnv"
            { directory = ".local/share/Steam"; }
            { directory = ".steam"; }
            ".config/obs-studio"
            ".config/discord"
            ".config/VencordDesktop"
            ".mozilla"
          ];
        };
      };
    })
  ]);
}
