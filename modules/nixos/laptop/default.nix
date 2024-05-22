{ config, lib, ... }:
with lib;
let cfg = config.Wotan.laptop;
in {
  options.Wotan.laptop.enable = mkEnableOption "Laptop";

  config = mkIf cfg.enable {
    services.thermald.enable = mkDefault true;
    services.tlp.settings = {
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    };
  };
}
