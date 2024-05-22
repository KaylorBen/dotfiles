{ lib, pkgs, config, ... }:
let cfg = config.Wotan.streaming;
in {
  options.Wotan.streaming = {
    enable =
      lib.mkEnableOption "Enable streaming specific kernel modules & install OBS";
  };

  config = lib.mkIf cfg.enable {
    boot.extraModulePackages = with config.boot.kernelPackages;
      [ v4l2loopback.out ];

    boot.kernelModules = [ "v4l2loopback" "snd-aloop" ];

    # Maybe move this to homeManager not sure
    environment.systemPackages = with pkgs; [
      cudatoolkit
      nv-codec-headers
      ffmpeg-full
      obs-studio
      obs-studio-plugins.obs-composite-blur
    ];
  };
}


