{ pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];
  Wotan = {
    virt.enable = true;
    autoUpgrade.enable = true;
    # chinese-lang.enable = true;
    users.enable = true;
    time.enable = true;
    gaming = {
      enable = true;
      # starCitizen.enable = false;
    };
    # flatpak = {
    #   enable = true;
    #   lutris = true;
    # };
    impermanence = {
      enable = true;
      rollbackCommand = ''
        zfs rollback -r zroot/NixOS/root@blank
      '';
    };
    streaming.enable = true;
    sound.enable = true;
    security = {
      enable = false;
      enableTPM = false;
    };
    styles.style = "tokyo-night-dark";
    desktop.hyprland = {
      enable = true;
    };
  };

  # boot.plymouth.enable = true;
  boot = {
    kernel.sysctl = {
      "net.ipv4.tcp_mtu_probing" = 1;
    };
    kernelParams = [
      "video=DP-1:3840x2160"
      # "video=HDMI-A-1:d"
    ];
  };

  networking = {
    networkmanager.enable = true;

    # firewall = {
    #   # if packets are still dropped, they will show up in dmesg
    #   logReversePathDrops = true;
    #   # wireguard trips rpfilter up
    #   extraCommands = ''
    #     ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 49860 -j RETURN
    #     ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 49860 -j RETURN
    #   '';
    #   extraStopCommands = ''
    #     ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 49860 -j RETURN || true
    #     ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 49860 -j RETURN || true
    #   '';
    #   allowedUDPPorts = [
    #     9987
    #   ];
    # };
  };

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  console.useXkbConfig = true;

  services = {
    libinput.enable = true;
    xserver = {
      enable = true;

      xkb = {
        layout = "us,us";
        variant = ",3l";
        options = "grp:rctrl_rshift_toggle";
      };
    };
    dbus.enable = true;
    openssh.enable = true;
    printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
      ];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    gvfs.enable = true;

    # logmein-hamachi.enable = true;

  };

  users.users.ben.packages = with pkgs; [
    ani-cli
    jdk
    prismlauncher
  ];

  environment.systemPackages = with pkgs; [
    # miru
    vim
    gh
    git
    imgcat
    sc-im
    os-prober
    tmux
    wget
    gnome-keyring
  ];

  # Disable autosleep
  systemd = {
    targets = {
      suspend.enable = true;
      hibernate.enable = true;
      hybrid-sleep.enable = true;
    };
  };
  programs = {
    ladybird.enable = true;
    nix-ld.enable = true;
    fuse.userAllowOther = true;
    kdeconnect.enable = true;
    fish.enable = true;
  };
}
