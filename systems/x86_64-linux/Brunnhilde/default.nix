{ pkgs, lib, ... }:
{
  imports = [ ./hardware-configuration.nix ];
  Wotan = {
    autoUpgrade.enable = true;
    zfs.enable = true;
    users.enable = true;
    time.enable = true;
    impermanence = {
      enable = true;
      rollbackCommand = ''
        zfs rollback -r zroot/encrypted/NixOS/root@blank
      '';
    };
    sound.enable = true;
    security = {
      enableTPM = false;
      # enableSecureBoot = true;
    };
    desktop = {
      hyprland.enable = true;
    };
  };
  boot.loader.systemd-boot.enable = lib.mkForce true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Plymouth
  boot.plymouth.enable = false;

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    mosh.enable = true;
    noisetorch.enable = true;
    partition-manager.enable = true;
  };
  networking = {
    networkmanager.enable = true;
    useDHCP = false;
    interfaces.wlp2s0.useDHCP = true;
  };
  services = {
    xserver = {
      enable = true;

      # Configure keymap in X11
      layout = "us";

      # Enable touchpad support
      libinput.enable = true;
    };

    openssh.enable = true;
  };

  environment.systemPackages = with pkgs; [
    firefox
    git
    nil
  ];

  security.polkit.enable = true;

  snowfallorg.users.ben.home.config = {
    Wotan.home-profiles.desktop.enable = true;
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
