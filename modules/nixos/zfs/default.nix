{ config, lib, ... }:
with lib;
let cfg = config.Wotan.zfs;
in {
  options.Wotan.zfs.enable = mkEnableOption "Enable ZFS specifics";
  config = mkIf cfg.enable {
    services.zfs = {
      autoScrub.enable = true;
      trim.enable = true;
    };

    boot.kernelPackages =
      mkForce config.boot.zfs.package.latestCompatibleLinuxPackages;
  };
}
