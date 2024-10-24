{
  config,
  inputs,
  lib,
  pkgs,
  format,
  ...
}:
with lib;
let
  cfg = config.Wotan.defaults;
in
{
  options.Wotan.defaults.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable nebula base defaults";
  };


  config = mkIf cfg.enable {
    boot.initrd.systemd.enable = mkDefault (format != "iso");
    # GIT is needed for flakes
    environment.systemPackages = with pkgs; [
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
      tldr
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

    # fonts = {
    #   fontDir.decompressFonts = mkDefault true;
    #   enableDefaultPackages = true;
    # };

    programs = {
      nano.enable = false;
      starship = {
        enable = mkDefault true;
        settings = {
          add_newline = mkDefault false;
          battery = mkDefault {
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
            show_always = mkDefault true;
            style_user = mkDefault "bold green";
            style_root = mkDefault "bold red";
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
      openssh = mkDefault {
        enable = true;
        settings.passwordAuthentication = false;
      };
    };
    nix = {
      # package = pkgs.nixFlakes;
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        trusted-users = [
          "builder"
          "root"
          "@wheel"
          "ben"
        ];
      };
      gc = {
        automatic = mkDefault true;
        options = mkDefault "--delete-older-than 30d";
      };
    };

    boot.supportedFilesystems = [
      "ntfs"
      "btrfs"
    ];
  };
}
