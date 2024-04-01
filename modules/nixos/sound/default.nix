{ lib, config, ... }:
let cfg = config.TM.sound;
in {
  options.TM.sound = {
    enable = lib.mkEnableOption "Enable sound";
    lowLatency = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable low latency mode";
    };
    support32Bit = lib.mkEnableOption {
      types = lib.types.bool;
      default = true;
      description = "Enable 32 bit support";
    };
  };

  config = lib.mkIf cfg.enable {
    sound.enable = true;
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

