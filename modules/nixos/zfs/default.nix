{ config, lib, ... }:
{
  options.Wotan.zfs.enable = lib.mkEnableOption "Enable ZFS specifics";
  config = lib.mkIf config.Wotan.zfs.enable {
    services.zfs = {
      autScrub.enable = true;
      time.enable = true;
    };

    boot.kernelPackages =
      lib.mkForce config.boot.zfs.package.latestCompatibleLinuxPackages;
  };
}
