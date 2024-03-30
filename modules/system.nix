{ pkgs, lib, ... }: let
  username = "ben";
in {
  users.users.ben = {
    isNormalUser = true;
    description = "ben";
    extraGroups = [ "wheel" "networkmanager" "wireshark" "video" ];
    shell = pkgs.nushell;
  };

  # customize /etc/nix/nix.conf declaratively via 'nix.settings'
  nix = { 
    package = pkgs.nixFlakes;
    settings = {
      experimental-features = ["nix-command" "flakes"];

      substituters = ["https://nix-gaming.cachix.org"];
      trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
      auto-optimise-store = true;

      builders-use-substitutes = true;

      trusted-users = [username];
    };
  };

  # auto upgrade on
  system.autoUpgrade = {
    enable = true;
    flake = "/home/ben/nix-config/#benix";
    flags = [ "--update-input" "nixpkgs" ];
  };

  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-run"
      "steamcmd"
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
      "discord"
      "starsector"
    ];

  # Set timezone.
  time.timeZone = "US/Mountain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable CUPS to print documents
  services.printing.enable = true;

  # List packages installed in system profile. To search run:
  # nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    pavucontrol
    wpa_supplicant_gui
    xclip
    # prismlauncher

    fflogs
    wowup
    
    firefox
  ];

  # Nix settings programs to enable
  programs = {
    dconf.enable = true;
    steam.enable = true;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Enable Sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    flatpak.enable = true;
    picom.enable = true;
  };
}

