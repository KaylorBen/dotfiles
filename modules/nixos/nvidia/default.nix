{ config, lib, ... }:
with lib;
let cfg = config.Wotan.MyNextGPUWillNotBeNvidia;
in {
  options.Wotan.MyNextGPUWillNotBeNvidia = mkEnableOption "Fix nvidia nonsense";

  config = mkIf cfg {
    services.xserver.videoDrivers = [ "nvidia" ];
    environment.sessionVariables = {
      A_DRIVER_NAME = mkDefault "nvidia";
      # May crash firefox
      GBM_BACKEND = mkDefault "nividia-drm";
      # May break scerensharing / Discord
      __GLX_VENDO_ARY_NAME = mkDefault "nvidia";
      WLR_NO_HARDWARE_CURSORS = mkDefault "1";
      # Unsure what this has the potential to break
      NIXOS_OZONE_WL = mkDefault "1";
    };
    hardware.nvidia = {
      package = mkDefault config.boot.kernelPackages.nvidiaPackages.beta;
      modesetting.enable = mkDefault true;
      open = mkDefault true;
      nvidiaSettings = mkDefault true;
    };
    hardware.nvidia.powerManagement.enable = mkDefault true;
    # hardware.nvidia.open = mkDefault false;
    # bool.kernelParams =  [ "nvidia_drm.fbdev=1" ];
    # Might need this for cosmic
  };
}
