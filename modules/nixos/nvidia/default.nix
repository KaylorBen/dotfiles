{ config, lib, ... }:
let cfg = config.Wotan.MyNextGPUWillNotBeNvidia;
in {
  options.Wotan.MyNextGPUWillNotBeNvidia = lib.mkEnableOption "Fix nvidia nonsense";

  config = lib.mkIf cfg {
    services.xserver.videoDrivers = [ "nvidia" ];
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = lib.mkDefault "nvidia";
      # May crash firefox
      GBM_BACKEND = lib.mkDefault "nividia-drm";
      # May break scerensharing / Discord
      __GLX_VENDO_LIBRARY_NAME = lib.mkDefault "nvidia";
      WLR_NO_HARDWARE_CURSORS = lib.mkDefault "1";
      # Unsure what this has the potential to break
      NIXOS_OZONE_WL = lib.mkDefault "1";
    };
    hardware.nvidia = {
      package = lib.mkDefault config.boot.kernelPackages.nvidia_x11_production;
      modesetting.enable = lib.mkDefault true;
      open = lib.mkDefault true;
      nvidiaSettings = lib.mkDefault true;
    };
    hardware.nvidia.powerManagement.enable = lib.mkDefault true;
    # hardware.nvidia.open = mkDefault false;
  };
}
