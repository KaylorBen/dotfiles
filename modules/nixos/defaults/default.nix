{ config, lib, inputs, pkgs, format, ... }:
{
  imports = [ (lib.Wotan.get-shared-module "defaults") ];
  config = lib.mkIf config.Wotan.defaults.enable {
    boot.initrd.systemd.enable = lib.mkDefault (format != "iso");
    # GIT is needed for flakes
    environment.systemPackages = with pkgs; [
      btop
      comma
      git
      htop
      rsync
      vim
      ripgrep
      ventoy
    ];
    environment.etc.FLAKE_CURRENT_COMMIT = {
      text = "${config.system.configurationRevision}";
    };
    system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev;

    fonts = {
      fontDir.decompressFonts = lib.mkDefault true;
      enableDefaultPackages = true;
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
        settings = { passwordAuthentication = false; };
      };
    };
    nix = {
      settings.trusted-users = [ "builder" "root" "@wheel" ];
      gc = {
        automatic = lib.mkDefault true;
        options = lib.mkDefault "--delete-older-than 30d";
      };
    };

    boot.supportedFilesystems = [ "ntfs" "btrfs" ];
  };
}
