{config, lib, pkgs, inputs, ...}:
{
  imports = [ ./hardware-configuration.nix ];
  Wotan = {
    # virt.enable = true;
    autoUpgrade.enable = true;
    users.enable = true;
    time.enable = true;
    gaming.enable = true;
    # flatpak = {
    #   enable = true;
    #   lutris = true;
    # };
    impermanence = {
      enable = true;
      rollbackCommand = ''
        zfs rollback -r zroot/encrypted/NixOS/root@blank
      '';
    };
    streaming.enable = true;
    sound.enable = true;
    # security.enable = true;
    desktop.awesome.enable = true;
  };

  # boot.plymouth.enable = true;

  networking = {
    networkmanager.enable = true;

    # TODO open ports in the firewall
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
    xserver = {
      enable = true;
      libinput.enable = true;

      xkb.layout = "us";
    };
    dbus.enable = true;
    openssh.enable = true;
  };

  users.users.ben.packages = with pkgs; [
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
      impermanence.enable = true;
      programs.git.enable=true;
    };
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };
  environment.systemPackages = with pkgs; [
    # miru
    vim
    gh
    git
    os-prober
    pamixer
    # nvtopPackages.full
    tmux
    wget
  ];

  # virtualisation = {
  #   libvirtd.enable = true;
    # waydroid.enable = true;
  # };

  # Disable autosleep
  systemd = {
    targets = {
      suspend.enable = true;
      hibernate.enable = true;
      hybrid-sleep.enable = true;
    };
  };
  programs = {
    fuse.userAllowOther = true;
    kdeconnect.enable = true;
    fish.enable = true;
  };
}
