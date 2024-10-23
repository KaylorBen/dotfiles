{ pkgs, inputs, ... }:
{
  imports = [ ./hardware-configuration.nix ];
  Wotan = {
    virt.enable = true;
    autoUpgrade.enable = true;
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
    desktop.hyprland = {
      enable = true;
    };
  };

  # boot.plymouth.enable = true;
  boot.kernel.sysctl = {
    "net.ipv4.tcp_mtu_probing" = 1;
  };

  networking = {
    networkmanager.enable = true;

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

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    # pixiecore =
    #   let inherit (inputs.self.nixosConfigurations.Netboot.config.system) build;
    #   in {
    #     enable = false;
    #     openFirewall = true;
    #     dhcpNoBind = true;
    #     mode = "boot";
    #     kernel = "${build.kernel}/bzImage";
    #     initrd = "${build.netbootRamdisk}/initrd";
    #     cmdLine = "init=${build.toplevel}/init loglevel=4";
    #     debug = true;
    #   };
    libinput.enable = true;
    xserver = {
      enable = true;

      xkb.layout = "us";
    };
    # dbus.enable = true;
    openssh.enable = true;
    printing.enable = true;
    # avahi = {
    #   enable = true;
    #   nssmdns4 = true;
    #   openFirewall = true;
    # };
    gvfs.enable = true;
  };

  users.users.ben.packages = with pkgs; [
    ani-cli
    jdk
    prismlauncher
    nil
    xclip
  ];

  snowfallorg.users.ben.home.config = {
    # home.persistence."/.FinalFantasyXIV" = {
    #   directories = [ ".xlcore" ];
    #   allowOther = true;
    # };
    programs.yazi.enable = true;
    Wotan = {
      home-profiles.desktop.enable = true;
      programs.git.enable = true;
      desktop.hyprland = {
        enable = true;
        extraSettings = {
          monitor = [
            "DP-1, preferred, 0x0, 1"
            "HDMI-A-1, preferred, 3840x0, 1, transform, 3"
          ];
        };
        plugins = with pkgs.hyprlandPlugins; [
          inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
        ];
        splitBinds = true;
        bar = "ags";
      };
    };
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };
  environment.systemPackages = with pkgs; [
    # miru
    cpulimit
    vim
    gh
    git
    imgcat
    os-prober
    pamixer
    # nvtopPackages.full
    tmux
    wget
  ];

  virtualisation = {
    # libvirtd.enable = true;
    # waydroid.enable = true;
  };

  # Disable autosleep
  systemd = {
    targets = {
      suspend.enable = true;
      hibernate.enable = true;
      hybrid-sleep.enable = true;
    };
  };
  programs = {
    nix-ld.enable = true;
    fuse.userAllowOther = true;
    kdeconnect.enable = true;
    fish.enable = true;
  };
}
