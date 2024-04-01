{ config, lib, pkgs, modulesPath, inputs, ... }:

{
  imports = with inputs; [ 
    (modulesPath + "/installer/scan/not-detected.nix")
    nixos-hardware.nixosModules.dell-xps-13-9310
  ];

  boot = {
    initrd = {
      systemd.enable = true;
      availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  Wotan = {
    zfs.enable = true;
    laptop = lib.mkDefault true;
  };

  hardware.nvidia.modesetting.enable = true;
  
  disko.devices = import ./disko.nix { inherit lib; };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
