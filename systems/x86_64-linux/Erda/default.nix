{ pkgs, lib, ... }: {
  imports = [ ./hardware-configuration.nix ];
  Wotan = {
    autoUpgrade.enable = true;
    users.enable = true;
    gaming = {
      enable = true;
      starCitizen.enable = false;
    };
    time.enable = true;
    sound.enable = true;
    desktop = { hyprland.enable = true; };
  };
  boot.loader.systemd-boot.enable = lib.mkForce true;
  boot.loader.efi.canTouchEfiVariables = true;

  programs = {
    noisetorch.enable = true;
  };

  networking = {
    networkmanager.enable = true;
  };
  services = {
    libinput.enable = true;
    xserver = {
      enable = true;

      xkb.layout = "us";
    };
    openssh.enable = true;

  };

  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    firefox
    git
    gh
    imgcat
    os-prober
    pamixer
    nil
    vim
    tmux
    wget
  ];

  security.polkit.enable = true;

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
