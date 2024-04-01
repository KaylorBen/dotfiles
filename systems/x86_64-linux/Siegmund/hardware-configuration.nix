{ config, lib, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    initrd = {
      systemd.enable = true;
      availableKernelModules =
        [ "xhci_pci" "ahci" "nvme" "usbhid" "uas" "usb_storage" "sd_mod" "sr_mod" ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };
  Wotan.MyNextGPUWillNotBeNvidia = true;
  Wotan.zfs.enable = true;
  # RAID stuff
  # environment.etc."mdadm.conf".text = ''
  #   MAILADDR root
  # '';

  disko.devices = import ./disko.nix { inherit lib; };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp6s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
