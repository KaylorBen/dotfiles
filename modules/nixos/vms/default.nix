{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.Wotan.virt;
in
{
  options.Wotan.virt.enable = mkEnableOption "Enable Virtualisation";

  config = mkIf cfg.enable {
    boot = {
      kernelModules = [ "kvm-amd" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
      kernelParams = [ "amd_iommu=on" "amd_iommu=pt" "kvm.ignore_msrs=1" ];
      extraModprobeConfig = "options vfio-pci ids=10de:220a,10de:1aef";
    };

    systemd.tmpfiles.rules = [
      "f /dev/shm/looking-glass 0660 ben qemu-libvirtd -"
    ];

    environment.systemPackages = with pkgs; [
      # quickemu
      virt-manager
      looking-glass-client
      distrobox
    ];
    virtualisation = {
      libvirtd = {
        enable = mkDefault true;
        extraConfig = ''
          user="ben"
        '';

        onBoot = "ignore";
        onShutdown = "shutdown";

        qemu = {
          package = pkgs.qemu_kvm;
          verbatimConfig = ''
            namespaces = []
            user = "+${builtins.toString config.users.users.ben.uid}"
          '';
          swtpm.enable = true;
        };
      };
      podman = {
        enable = true;
      };
    };

    users.users.ben.extraGroups = [ "libvirt-qemu" "libvirt" "disk" "KVM" ];
  };
}
