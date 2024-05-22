{ config, lib, ... }:
let cfg = config.Wotan.zfs;
in {
  options.Wotan.zfs.enable = lib.mkEnableOption "Enable ZFS specifics";
  config = lib.mkIf cfg.enable {
    services.zfs = {
      autoScrub.enable = true;
      trim.enable = true;
    };

    boot.kernelPackages =
      lib.mkForce config.boot.zfs.package.latestCompatibleLinuxPackages;
  };
}
