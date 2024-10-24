{ config, lib, ... }:
with lib;
let
  cfg = config.Wotan.MyNextGPUWillNotBeNvidia;
in
{
  options.Wotan.MyNextGPUWillNotBeNvidia = mkEnableOption "Fix nvidia nonsense";

  config = mkIf cfg {
    boot.extraModprobeConfig = ''options nvidia NVreg_RegistryDwords="PowerMizerEnable=0x1; PerfLevelSrc=0x2222; PowerMizerLevel=0x3; PowerMizerDefault=0x3; PowerMizerDefaultAC=0x3"'';
    services.xserver.videoDrivers = [ "nvidia" ];
    environment.sessionVariables = {
      A_DRIVER_NAME = mkDefault "nvidia";
      # May crash firefox
      GBM_BACKEND = mkDefault "nividia-drm";
      # May break scerensharing / Discord
      __GLX_VENDOR_LIBRARY_NAME = mkDefault "nvidia";
      LIBVA_DRIVER_NAME = "nvidia";
      __GL_VRR_ALLOWED = "1";
      # Unsure what this has the potential to break
      NIXOS_WAYLAND = "1";
      NIXOS_OZONE_WL = mkDefault "1";
      WLR_RENDERER = "vulkan";
      WLR_RENDERER_ALLOW_SOFTWARE = "1";
    };
    hardware.nvidia = {
      package = mkDefault config.boot.kernelPackages.nvidiaPackages.beta;
      modesetting.enable = mkDefault true;
      open = mkDefault true;
      nvidiaSettings = mkDefault true;

      prime = {
        sync.enable = true;

        # Bus IDs for Desktop
        nvidiaBusId = "PCI:1:0:0";
        intelBusId = "PCI:0:1:0";
      };
    };
    hardware.nvidia.powerManagement.enable = mkDefault false;
    # hardware.nvidia.open = mkDefault false;
    # bool.kernelParams =  [ "nvidia_drm.fbdev=1" ];
    # Might need this for cosmic
  };
}
