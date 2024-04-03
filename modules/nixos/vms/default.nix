{ config, lib, pkgs, ... }:
{
  options.Wotan.virt.enable = lib.mkEnableOption "Enable Virtualisation";

  config = lib.mkIf config.Wotan.virt.enable {
    virtualisation = {
      libvirtd = {
        enable = lib.mkDefault true;
        package = lib.mkDefault pkgs.qemu_kvm;
        qemu = {
          swtpm.enable = lib.mkDefault true;
          ovmf = {
            enable = true;
            packages = [
              (pkgs.OVMF.override {
                secureBoot = true;
                tpmSupport = true;
              }).fd
            ];
          };
        };
      };
    };
  };
}
