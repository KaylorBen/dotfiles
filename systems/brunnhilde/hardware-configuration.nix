{
  config,
  lib,
  inputs,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.dell-xps-13-9310
  ];

  boot = {
    initrd = {
      systemd.enable = true;
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "usb_storage"
        "sd_mod"
        "rtsx_pci_sdmmc"
      ];
      kernelModules = [ ];
    };
    binfmt.emulatedSystems = [
      "aarch64-linux"
      "riscv32-linux"
      "riscv64-linux"
      "x86_64-windows"
    ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };
  services = {
    fwupd.enable = true;
  };
  networking = {
    hostName = "Brunnhilde";
    hostId = "7c40a3b8";
  };
  Wotan = {
    laptop.enable = lib.mkDefault true;
  };

  disko.devices = import ./disko.nix { inherit lib; };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  # networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
