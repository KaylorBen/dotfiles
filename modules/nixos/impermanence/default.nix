{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.Wotan.impermanence;
  dir = directory: user: group: mode: {
    inherit
      directory
      user
      group
      mode
      ;
  };
in
{
  options.Wotan.impermanence = {
    enable = mkEnableOption "impermanence";
    rollbackCommand = mkOption {
      type = types.str;
      description = "Command to remove all impermanent files";
    };
    persistentDirectory = mkOption {
      type = types.str;
      description = "Directory to store persistent files";
      default = "/.persistent";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    (mkIf config.Wotan.zfs.enable {
      # Handles rollbacks for ZFS, disabled to ensure paths are fully set
      boot.initrd.systemd.services.impermanence = {
        description = "Resets root to a clean state (Requires ZFS)";
        wantedBy = [ "initrd.target" ];
        after = [ "zfs-import-zroot.service" ];
        before = [ "sysroot.mount" ];
        path = with pkgs; [ zfs_unstable ];
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script = cfg.rollbackCommand;
      };
    })
    # Broken
    # (mkIf (!config.Wotan.zfs.enable && cfg.boot.bcache.enable) {
    #   boot.initrd = {
    #     enable = true;
    #     supportedFilesystems = [ "bcachefs" ];
    #
    #     postResumeCommands = lib.mkAfter ''
    #       mkdir -p /mnt
    #       # We mount the whole bcachefs filesystem. Now its time to save our data.
    #       mount --mkdir /dev/nvme0n1p2 /mnt/
    #
    #       # Bcachefs snapshots are virtually free, so we can create a bunch to
    #       # save our data, then reset root and restore them.
    #       # Unfortunately a few features useful for this (mount a single subvol and
    #       # list all subvolumes) are not available.
    #       bcachefs subvolume delete /mnt/.snapshots/*
    #       bcachefs subvolume snapshot /mnt/home /mnt/.snapshots/home
    #       bcachefs subvolume snapshot /mnt/nix /mnt/.snapshots/nix
    #       bcachefs subvolume snapshot /mnt/.persistent /mnt/.snapshots/persistent
    #       bcachefs subvolume snapshot /mnt/var/logs /mnt/.snapshots/logs
    #
    #       # Now we destoy current root. Not sure if this is the best way to do this.
    #       bcachefs subvolume delete /mnt/home
    #       bcachefs subvolume delete /mnt/nix
    #       bcachefs subvolume delete /mnt/.persistent
    #       bcachefs subvolume delete /mnt/var/logs
    #       export GLOBIGNORE="/mnt/.snapshots:.:.."
    #       rm -rf /mnt/*
    #
    #       # And restore
    #       bcachefs subvolume snapshot /mnt/.snapshots/home /mnt/home
    #       bcachefs subvolume snapshot /mnt/.snapshots/nix /mnt/nix
    #       bcachefs subvolume snapshot /mnt/.snapshots/persistent /mnt/.persistent
    #       mkdir /mnt/var
    #       bcachefs subvolume snapshot /mnt/.snapshots/logs /mnt/var/logs
    #     '';
    #   };
    # })
    {
      fileSystems.${cfg.persistentDirectory}.neededForBoot = true;
      environment.persistence.${cfg.persistentDirectory} = {
        hideMounts = true;
        directories = [
          # (dir "/var/log" "root" "root" "u=rwx,g=rx,o=rx")
          (dir "/var/lib/bluetooth" "root" "root" "u=rwx,g=,o=")
          (dir "/var/lib/foundryvtt" "foundryvtt" "foundryvtt" "u=rwx,g=rx,o=")
          (dir "/var/lib/nixos" "root" "root" "u=rwx,g=rx,o=rx")
          (dir "/var/lib/systemd/coredump" "root" "root" "u=rwx,g=rx,o=rx")
          (dir "/etc/NetworkManager/system-connections" "root" "root" "u=rwx,g=,o=")
          "/var/lib/flatpak"
          (dir "/var/lib/alsa" "root" "root" "u=rwx,g=rx,o=rx")

          (dir "/var/db/sudo" "root" "root" "u=rwx,g=,o=")
          (dir "/etc/fwupd" "root" "root" "u=rwx,g=rx,o=rx")
          (dir "/etc/ssh/authorized_keys.d" "root" "root" "u=rwx,g=rx,o=rx")
          (dir "/etc/nix" "root" "root" "u=rwx,g=rx,o=rx")
        ];
        files = [
          "/etc/machine-id"
          # {
          #   file = "/etc/nix/id_rsa";
          #   parentDirectory = { mode = "u=rwx,g=,o="; };
          # }
          "/etc/adjtime"
          "/etc/ssh/ssh_host_ed25519_key"
          "/etc/ssh/ssh_host_ed25519_key.pub"
          "/etc/ssh/ssh_host_rsa_key"
          "/etc/ssh/ssh_host_rsa_key.pub"
        ];
      };
    }
    (mkIf config.Wotan.users.enable {
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
            "Modding"
            "Documents"
            "Videos"
            "VMs"
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
            ".mozilla"
          ];
        };
      };
    })
  ]);
}
