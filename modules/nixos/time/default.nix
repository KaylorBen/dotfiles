{ config, lib, ... }:
with lib;
let cfg = config.Wotan.time;
in {
  options.Wotan.time = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable System time. Uses timesyncd to sync time.";
    };
    hwclock = mkOption {
      type = types.bool;
      default = true;
      description = "Hardware clock";
    };
  };

  config = mkIf cfg.enable {
    time.hardwareClockInLocalTime = cfg.hwclock;
    time.timeZone = "America/New_York";
    services.timesyncd.enable = mkDefault true;
    services.automatic-timezoned.enable = mkDefault true;
    services.geoclue2.enable = true;
    services.geoclue2.enableDemoAgent = mkForce true;
  };
}
