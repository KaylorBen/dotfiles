{ pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];
  Wotan = {
    autoUpgrade.enable = true;
    chinese-lang.enable = true;
    users.enable = true;
    time.enable = true;
    gaming = {
      enable = true;
      starCitizen.enable = false;
    };
    sound.enable = true;
    styles.style = "tokyo-night-dark";
    desktop.hyprland = {
      enable = true;
    };
  };

  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  services = {
    libinput.enable = true;
    xserver = {
      enable = true;

      xkb.layout = "us";
    };
    dbus.enable = true;
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
  ];

  environment.systemPackages = with pkgs; [
    # miru
    vim
    gh
    git
    imgcat
    os-prober
    pamixer
    # nvtopPackages.full
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
    nix-ld.enable = true;
    fuse.userAllowOther = true;
    kdeconnect.enable = true;
    fish.enable = true;
  };
}
