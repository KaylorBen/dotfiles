{ config, lib, ... }:
{
  options.Wotan.zfs.enable = lib.mkEnableOption "Enable ZFS specifics";
  config = lib.mkIf config.Wotan.zfs.enable {
    services.zfs = {
      autoScrub.enable = true;
      trim.enable = true;
    };

    boot.kernelPackages =
      lib.mkForce config.boot.zfs.package.latestCompatibleLinuxPackages;
  };
}
