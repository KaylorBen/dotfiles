{ config,  pkgs, lib,... }:
with lib;
let cfg = config.Wotan.virt;
in {
  options.Wotan.virt.enable = mkEnableOption "Enable Virtualisation";

  config = mkIf cfg.enable {
    virtualisation = {
      libvirtd = {
        enable = mkDefault true;
        package = mkDefault pkgs.qemu_kvm;
        qemu = {
          swtpm.enable = mkDefault true;
          # ovmf = {
          #   enable = true;
          #   packages = [
          #     (pkgs.OVMF.override {
          #       # secureBoot = true;
          #       tpmSupport = true;
          #     }).fd
          #   ];
          # };
        };
      };
    };
  };
}
