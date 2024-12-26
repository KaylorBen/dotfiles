{
  config,
  lib,
  ...
}:
{
  # Use the systemd-boot EFI boot loader
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    binfmt.emulatedSystems = [
      "aarch64-linux"
      "x86_64-windows"
      "wasm32-wasi"
      "wasm64-wasi"
      "riscv32-linux"
      "riscv64-linux"
    ];
    supportedFilesystems = [ "ntfs" ];
    initrd = {
      systemd.enable = true;
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "uas"
        "usb_storage"
        "sd_mod"
        "sr_mod"
      ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  services = {
    thermald.enable = true;
    fwupd.enable = true;
  };

  hardware = {
    openrazer = {
      enable = true;
      users = [ config.users.users.ben.name ];
    };
  };
  networking = {
    hostName = "wolfram";
    hostId = "8bca3819";
  };
  Wotan = {
    MyNextGPUWillNotBeNvidia = true;
    # services.liquidctl = {
    #   enable = true;
    #   TODO: find cooler model and configure
    #   config = {
    #   };
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  networking.interfaces.enp6s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
