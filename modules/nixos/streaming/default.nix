{ pkgs, lib, config, ... }:
with lib;
let cfg = config.Wotan.streaming;
in {
  options.Wotan.streaming = {
    enable =
      mkEnableOption "Enable streaming specific kernel modules & install OBS";
  };

  config = mkIf cfg.enable {
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


