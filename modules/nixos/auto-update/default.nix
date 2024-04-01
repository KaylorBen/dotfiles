# Enables system upgrades using system.autoUpgrade
{ lib, config, pkgs, ...}:
let cfg = config.Wotan.autoUpgrade;
in {
  options.Wotan.autoUpgrade = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable autoupgrades";
    };
    operation = lib.mkOption {
      type = lib.types.enum [ "switch" "boot" ];
      default = "switch";
    };
    dates = lib.mkOption {
      type = lib.types.str;
      default = "daily";
    };
    allowReboot =
      lib.mkEnableOption "Allow rebooting for kernel, module or initrd updates";
    randomizedDelaySec = lib.mkOption {
      type = lib.types.str;
      default = "1h";
      description = lib.mdDoc
        "Randomized delay for upgrades format must me {manpage}`systemd.time(7)`";
    };
    persistent = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable persistent upgrades";
    };
  };

  config = lib.mkIf cfg.enable {
    # Git is needed for the flake to be abkle to update itself
    environment.systemPackages = [ pkgs.git ];
    nix.settings.experimental-features = [ "nix-command flakes" ];

    system.autoUpgrade = {
      inherit (cfg) enable;
      inherit (cfg) operation;
      inherit (cfg) dates;
      inherit (cfg) allwReboot;
      inherit (cfg) randomizedDelaySec;
      inherit (cfg) persistent;
      flake = lib.Wotan.info.url;
    };
  };
}
