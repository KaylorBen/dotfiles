{ config, lib, pkgs, modulesPath, inputs, ... }:
{
  imports = with inputs; [
    (modulesPath + "/installer/scan/not-detected.nix")
    nixos-hardware.nixosModules.common-cpu-intel-cpu-only
    nixos-hardware.nixosModules.common-gpu-intel-disable
    nixos-hardware.nixosModules.common-pc-ssd
  ];
  # Use the systemd-boot EFI boot loader
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # binfmt.emulatedSystems = [
    #   "aarch64-linux"
    #   "x86_64-windows"
    #   "wasm32-wasi"
    #   "wasm64-wasi"
    #   "riscv32-linux"
    #   "riscv64-linux"
    # ];
    supportedFilesystems = [ "ntfs" ];
    initrd = {
      systemd.enable = true;
      availableKernelModules =
        [ "xhci_pci" "ahci" "nvme" "usbhid" "uas" "usb_storage" "sd_mod" "sr_mod" ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };
  powerManagement.cpuFreqGovernor = "performance";

  services = {
    blueman.enable = true;
    # fwupd.enable = true;
    # hardware.openrgb = {
    #   enable = true;
    #   package = pkgs.openrgb-with-all-plugins;
    # };
    # udev.packages = with pkgs; [ liquidctl ];
  };

  hardware = {
    bluetooth = {
      enable = true;
      settings.general.enable = "Source,Sink,Media,Socket";
    };
    openrazer = {
      enable = false;
      users = [ config.users.users.ben.name ];
    };
  };
  networking = {
    hostName = "Siegmund";
    hostId = "ffcb235e";
  };

  # # Set docker storage driver to btrfs
  # virtualisation.docker.storageDriver = "btrfs";
  # virtualisation.vmVariant = {
  #   disko.devices = lib.mkForce (import ./disko-vm.nix { inherit lib; });
  # };

  Wotan = {
    MyNextGPUWillNotBeNvidia = true;
    # services.liquidctl = {
    #   enable = true;
    #   TODO: find cooler model and configure
    #   config = {
    #   };
  };

  Wotan.zfs.enable = true;
  # RAID stuff
  # environment.etc."mdadm.conf".text = ''
  #   MAILADDR root
  # '';

  disko.devices = import ./disko.nix { inherit lib; };
  fileSystems."/.persistent".neededForBoot = true;

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  networking.interfaces.enp6s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
