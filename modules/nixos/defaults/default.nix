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
      git
      htop
      p7zip
      ripgrep
      rsync
      sl
      tldr
      vim
      man-pages
      unrar
      unzip
      xz
      zip
    ];
    environment.etc.FLAKE_CURRENT_COMMIT = {
      text = "${config.system.configurationRevision}";
    };

    system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev;
    system.stateVersion = pkgs.myLib.stateVersion.nixos;

    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        nerd-fonts.fira-code
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif

        (pkgs.callPackage ../../../packages/feather-font/default.nix { inherit pkgs; })

        liberation_ttf
      ];
      fontconfig = {
        enable = true;
        defaultFonts = {
          serif = [
            "FiraCode Nerd Font"
            "Noto Serif Simplified Chinese"
          ];
          sansSerif = [
            "FiraCode Nerd Font"
            "Noto Sans Simplified Chinese"
          ];
          monospace = [
            "FiraCode Nerd Font"
            "Noto Sans Simplified Chinese"
          ];
        };
      };
    };

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
        dates = "weekly";
        persistent = true;
        options = mkDefault "--delete-older-than 30d";
      };
    };

    boot.supportedFilesystems = [
      "ntfs"
      "btrfs"
    ];
  };
}
