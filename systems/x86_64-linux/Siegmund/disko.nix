{ disks ? [ "nvme0n1" "nvme1n1" "sda" ], lib, secretFile ? "/tmp/secret.key", ... }:
let
  defineZfs = idx: {
    type = "disk";
    device = "/dev/nvme${builtins.toString idx}n1";
    content = {
      type = "gpt";
      partitions = {
        zfs = {
          size = "100%";
          content = {
            type = "zfs";
            pool = "zroot";
          };
        };
      };
    };
  };
  b = builtins.elemAt disks 0;
in {
  disk = {
    x = defineZfs 1;
    z = {
      type = "disk";
      device = "/dev/${b}";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            size = "2G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "noFail" ];
            };
          };
          swap = {
            size = "100%";
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
      mode = "mirror";
      rootFsOptions = {
        compression = "zstd-5";
        "com.sun:auto-snapshot" = "false";
        acltype = "posixacl";
        xattr = "sa";
        mountpoint = "none";
      };
      datasets = {
        NixOS = {
          type = "zfs_fs";
          options = {
            encryption = "aes-256-gcm";
            keyformat = "passphrase";
            keylocation = "prompt";
          };
        };
        "NixOS/root" = {
          type = "zfs_fs";
          mountpoint = "/";
          postCreateHook = "zfs snapshot zroot/NixOS/root@blank";
        };
        "NixOS/persist" = {
          type = "zfs_fs";
          mountpoint = "/.persist";
        };
        "NixOS/nix" = {
          type = "zfs_fs";
          mountpoint = "/nix";
        };
        "NixOS/home" = {
          type = "zfs_fs";
          mountpoint = "/home";
        };
        "NixOS/logs" = {
          type = "zfs_fs";
          mountpoint = "/var/logs";
        };
      };
    };
  };
}
