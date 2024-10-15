{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.Wotan.zfs;
  isUnstable = config.boot.zfs.package == pkgs.zfsUnstable;
  zfsCompatibleKernelPackages = lib.filterAttrs (
    name: kernelPackages:
    (builtins.match "linux_[0-9]+_[0-9]+" name) != null
    && (builtins.tryEval kernelPackages).success
    && (
      (!isUnstable && !kernelPackages.zfs.meta.broken)
      || (isUnstable && !kernelPackages.zfs_unstable.meta.broken)
    )
  ) pkgs.linuxKernel.packages;
  latestKernelPackage = lib.last (
    lib.sort (a: b: (lib.versionOlder a.kernel.version b.kernel.version)) (
      builtins.attrValues zfsCompatibleKernelPackages
    )
  );
in
{
  options.Wotan.zfs.enable = mkEnableOption "Enable ZFS specifics";
  config = mkIf cfg.enable {
    services.zfs = {
      autoScrub.enable = true;
      trim.enable = true;
    };

    systemd.targets = {
      hibernate.enable = mkForce false;
      hybrid-sleep.enable = mkForce false;
    };

    boot.kernelPackages = mkForce latestKernelPackage;
  };
}
