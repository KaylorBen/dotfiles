{ config, lib, ... }:
{
  options.Wotan.MyNextGPUWillNotBeNvidia = lib.mkEnableOption "Fix nvidia nonsense";

  config = lib.mkIf config.Wotan.MyNextGPUWillNotBeNvidia{
    services.xserver.videoDrivers = [ "nvidia" ];
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = lib.mkDefault "nvidia";
      # May crash firefox
      GBM_BACKEND = lib.mkDefault "nividia-drm";
      # May break scerensharing / Discord
      __GLX_VENDO_LIBRARY_NAME = lib.mkDefault "nvidia";
      WLR_NO_HARDWARE_CURSORS = lib.mkDefault "1";
      # Unsure what this has the optential to break
      NIXOS_OZONE_WL = lib.mkDefault "1";
    };
    hardware.nvidia = {
      package = lib.mkDefault config.boot.kernelPackages.nvidia_xll_production;
      modesetting.enable = lib.mkDefault true;
      open = lib.mkDefault true;
      nvidiaSettings = lib.mkDefault true;
    };
    hardware.nvidia.powerManagement.enable = lib.mkDefault true;
    # hardware.nvidia.open = mkDefault false;
  };
}
