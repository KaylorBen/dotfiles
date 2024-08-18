{ config, lib, ... }:
with lib;
let cfg = config.Wotan.desktop.cosmic;
in {
  options.Wotan.desktop.cosmic = {
    enable = mkEnableOption "Cosmic DE";
  };

  config = mkIf cfg.enable {
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;
    services.displayManager.defaultSession = "cosmic";

    nix.settings = let
      substituters = [
        "https://cosmic.cachix.org/"
      ];
      trusted-public-keys = [
        "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      ];
    in {
      inherit substituters trusted-public-keys;
      trusted-substituters = substituters;
      extra-trusted-public-keys = trusted-public-keys;
    };
  };
}
