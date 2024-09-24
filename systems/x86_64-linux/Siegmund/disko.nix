{ disks ? [ "nvme0n1" "nvme1n1" "sda" "sdb" ], ... }: {
  disk = {
    main = {
      type = "disk";
      device = "/dev/nvme0n1";
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
            end = "-64G";
            content = {
              type = "zfs";
              pool = "zroot";
            };
          };
          swap = {
            size = "64G";
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
        "NixOS/root" = {
          type = "zfs_fs";
          mountpoint = "/";
          postCreateHook = "zfs snapshot zroot/NixOS/root@blank";
        };
        # No reason to back this up, it can be recreated
        "NixOS/nix" = {
          type = "zfs_fs";
          mountpoint = "/nix";
        };
        "NixOS/safe" = {
          type = "zfs_fs";
          options = {
            mountpoint = "none";
            "com.sun:auto-snapshot" = "true";
          };
        };
        "NixOS/safe/home" = {
          type = "zfs_fs";
          mountpoint = "/home";
        };
        "NixOS/safe/persistent" = {
          type = "zfs_fs";
          mountpoint = "/.persistent";
        };
        "NixOS/safe/logs" = {
          type = "zfs_fs";
          mountpoint = "/var/logs";
        };
      };
    };
  };
}
