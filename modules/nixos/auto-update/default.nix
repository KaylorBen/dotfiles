# Enables system upgrades using system.autoUpgrade
{ config, lib, pkgs, ... }:
with lib;
let cfg = config.Wotan.autoUpgrade;
in {
  options.Wotan.autoUpgrade = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable autoupgrades";
    };
    operation = mkOption {
      type = types.enum [ "switch" "boot" ];
      default = "switch";
    };
    dates = mkOption {
      type = types.str;
      default = "daily";
    };
    allowReboot =
      mkEnableOption "Allow rebooting for kernel, module or initrd updates";
    randomizedDelaySec = mkOption {
      type = types.str;
      default = "1h";
      description = mdDoc
        "Randomized delay for upgrades format must me {manpage}`systemd.time(7)`";
    };
    persistent = mkOption {
      type = types.bool;
      default = true;
      description = "Enable persistent upgrades";
    };
  };

  config = mkIf cfg.enable {
    # Git is needed for the flake to be abkle to update itself
    environment.systemPackages = [ pkgs.git ];
    # nix.settings.experimental-features = [ "nix-command flakes" ];

    system.autoUpgrade = {
      inherit (cfg) enable;
      inherit (cfg) operation;
      inherit (cfg) dates;
      inherit (cfg) allowReboot;
      inherit (cfg) randomizedDelaySec;
      inherit (cfg) persistent;
      flake = Wotan.info.url;
    };
  };
}
