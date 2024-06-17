{ disks ? [ "/dev/nvme0n1" ], secretFile ? "/tmp/secret.key", lib, ... }: {
  disk = {
    main = {
      type = "disk";
      device = "/dev/${builtins.elemAt disks 0}";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            size = "5G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          root = {
            end = "-16G";
            content = {
              type = "zfs";
              pool = "zroot";
            };
          };
          swap = {
            size = "16G";
            content = {
              type = "swap";
              randomEncryption = true;
              resumeDevice = true;
            };
          };
        };
      };
    };
  };
  zpool = {
    zroot = {
      type = "zpool";
      rootFsOptions = {
        compression = "zstd-5";
        "com.sun:auto-snapshot" = "false";
        acltype = "posixacl";
        xattr = "sa";
        mountpoint = "none";
      };
      datasets = {
        encrypted = {
          type = "zfs_fs";
          options = {
            mountpoint = "none";
            encryption = "aes-256-gcm";
            keyformat = "passphrase";
          };
        };
        "encrypted/NixOS/root" = {
          type = "zfs_fs";
          mountpoint = "/";
          postCreateHook = "zfs snapshot zroot/encrypted/NixOS/root@blank";
        };
        # No reason to back this up, it can be recreated
        "encrypted/NixOS/nix" = {
          type = "zfs_fs";
          mountpoint = "/nix";
        };
        "encrypted/NixOS/safe" = {
          type = "zfs_fs";
          options = {
            mountpoint = "none";
            "com.sun:auto-snapshot" = "true";
          };
        };
        "encrypted/NixOS/safe/home" = {
          type = "zfs_fs";
          mountpoint = "/home";
        };
        "encrypted/NixOS/safe/persistent" = {
          type = "zfs_fs";
          mountpoint = "/.persistent";
        };
        "encrypted/NixOS/safe/logs" = {
          type = "zfs_fs";
          mountpoint = "/var/logs";
        };
      };
    };
  };
}
