{ config, lib, ... }:
with lib;
let cfg = config.Wotan.sound;
in {
  options.Wotan.sound = {
    enable = mkEnableOption "Enable sound";
    lowLatency = mkOption {
      type = types.bool;
      default = true;
      description = "Enable low latency mode";
    };
    support32Bit = mkEnableOption {
      types = types.bool;
      default = true;
      description = "Enable 32 bit support";
    };
  };

  config = mkIf cfg.enable {
    # sound.enable = true;
    sound.mediaKeys.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        inherit (cfg) support32Bit;
      };
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
      lowLatency.enable = cfg.lowLatency;
    };
  };
}

