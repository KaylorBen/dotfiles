{ config, lib, inputs, pkgs, format, ... }:
{
  options.Wotan.defaults.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable nebula base defaults";
  };

  config = lib.mkIf config.Wotan.defaults.enable {
    boot.initrd.systemd.enable = lib.mkDefault (format != "iso");
    # GIT is needed for flakes
    environment.systemPackages = with pkgs; [
      btop
      cbonsai
      comma
      cowsay
      fastfetch
      git
      htop
      p7zip
      ripgrep
      rsync
      sl
      vim
      ventoy
      unrar
      unzip
      xz
      zip
    ];
    environment.etc.FLAKE_CURRENT_COMMIT = {
      text = "${config.system.configurationRevision}";
    };
    system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev;

    fonts = {
      fontDir.decompressFonts = lib.mkDefault true;
      enableDefaultPackages = true;
      packages = with pkgs; [
        fantasque-sans-mono
        fira-code
        nerdfonts
      ];
    };

    programs = {
      starship = {
        enable = lib.mkDefault true;
        settings = {
          add_newline = lib.mkDefault false;
          battery = lib.mkDefault {
            full_symbol = "🔋";
            charging_symbol = "⚡️";
            discharging_symbol = "💀";
            display = [
              {
                threshold = 10;
                style = "bold red";
              }
              {
                threshold = 30;
                style = "bold yellow";
              }
            ];
          };
          username = {
            show_always = lib.mkDefault true;
            style_user = lib.mkDefault "bold green";
            style_root = lib.mkDefault "bold red";
          };
          directory = {
            substitutions = {
              "Documents" = "󰈙 ";
              "Downloads" = " ";
              "Music" = " ";
              "Pictures" = " ";
            };
          };
        };
      };
    };
    services = {
      openssh = lib.mkDefault {
        enable = true;
        settings.passwordAuthentication = false;
      };
    };
    nix = {
      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        trusted-users = [ "builder" "root" "@wheel" ];
      };
      gc = {
        automatic = lib.mkDefault true;
        options = lib.mkDefault "--delete-older-than 30d";
      };
    };

    boot.supportedFilesystems = [ "ntfs" "btrfs" ];
  };
}
