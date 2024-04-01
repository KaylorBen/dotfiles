{ lib, config, ... }:
let cfg = config.Wotan.time;
in {
  options.Wotan.time = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable System time. Uses timesyncd to sync time.";
    };
    hwclock = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Hardware clock";
    };
  };

  config = lib.mkIf cfg.enable {
    time.hardwareClockInLocalTime = cfg.hwclock;
    services.timesyncd.enable = lib.mkDefault true;
    services.automatic-timezoned.enable = lib.mkDefault true;
    services.geoclue2.enable = true;
    services.geoclue2.enableDemoAgent = lib.mkForce true;
  };
}
