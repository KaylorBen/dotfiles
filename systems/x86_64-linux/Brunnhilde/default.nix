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
    kmscon.enable = true;
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
    firewall = {
      # if packets are still dropped, they will show up in dmesg
     logReversePathDrops = true;
     # wireguard trips rpfilter up
     extraCommands = ''
       ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 49860 -j RETURN
       ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 49860 -j RETURN
     '';
     extraStopCommands = ''
       ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 49860 -j RETURN || true
       ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 49860 -j RETURN || true
     '';
    };
  };
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
  services = {
    xserver = {
      enable = true;

      # Configure keymap in X11
      xkb.layout = "us";

      # Enable touchpad support
      libinput.enable = true;
    };

    openssh.enable = true;

    blueman.enable = true;
  };

  environment.systemPackages = with pkgs; [
    firefox
    git
    nil
  ];

  security.polkit.enable = true;

  users.users.ben.packages = with pkgs; [
    ani-cli
  ];

  snowfallorg.users.ben.home.config = {
    Wotan = {
      home-profiles.desktop.enable = true;
      styles = {
        enable = true;
        style = "rose-pine";
      };
    };
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
