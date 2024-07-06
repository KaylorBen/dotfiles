_: {
  services.openssh.enable = true;
  networking.wireless.enable = false;
  networking.networkmanager.enable = true;
  programs.starship.enable = true;
  boot.initrd.systemd.enable = false;
  Wotan = {
    laptop.enable = true;
    autoUpgrade.enable = false;
  };
}
