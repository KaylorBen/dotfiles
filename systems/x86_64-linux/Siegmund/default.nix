{config, lib, pkgs, inputs, ...}:
{
  imports = [ ./hardware-configuration.nix ];
  Wotan = {
    virt.enable = true;
    autoUpgrade.enable = true;
    users.enable = true;
    time.enable = true;
    gaming.enable = true;
    nvidia.enable = true;
    streaming.enable = true;
    sound.enable = true;
    # TODO security
    desktop.awesome.enable = true;
    styles = {
      enable = true;
      wallpaper = ./wallpaper.png;
      editImage = true;
    };
  };

  boot.plymouth.enable = true;

  networking = {
    hostName = "Siegmund";

    networkmanager.enable = true;

    # TODO open ports in the firewall
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    # Consider pixiecore netbooting
    xserver = {
      enable = true;
      libinput.enable = true;

      xkb.layout = "us";
    };
    dbus.enable = true;
    openssh.enable = true;
  };

  users.users.ben.packages = with pkgs; [
    prismlauncher
    nil
    xclip
  ];

  # Questionable functionality
  snowfall.users.ben.config = {
    home.persistnce."/.FinalFantasyXIV" = {
      directories = [ ".xlcore" ];
      allowOther = true;
    };
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
    tmux
    wget
  ];

  virtualisation = {
    libvirtd.enable = true;
    waydroid.enable = true;
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
    fuse.userAllowOther = true;
    kdeconnect.enable = true;
    noisetorch.enable = true;
    fzf.fuzzyCompletion = true;
    fish.enable = true;
  };
}
