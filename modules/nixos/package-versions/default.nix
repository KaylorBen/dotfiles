{ lib, config, ... }:
{
  options.Wotan.current-system-pacakges = {
    enable = lib.mkEnableOption "Store all packages and versions" // {
      default = true;
    };
  };

  config = lib.mkIf config.Wotan.current-system-pacakges.enable {
    environment.etc.current-system-pacakges.text = let
      packages =
        builtins.map (p: "${p.name}") config.environment.systemPackages;
      sortedUnique = builtins.sort builtins.lessThan (lib.unique packages);
      formatted = builtins.concatStringsSep "\n" sortedUnique;
    in formatted;
    /* #nixos/nixpks PR 208902
       https://github.com/NixOS/nixpkgs/blob/846dbcc597c4cd3156502a3a5508649109c11544/nixos/modules/system/activation/activation-script.nix#L209
    */
    system.userActivationScripts.diff = ''
      if [[ -e /run/current-system ]]; then
          ${config.nix.package}/bin/nix ---extra-experimental-features 'nix-command' store diff-closures /run/current-system "$systemConfig" || true
        fi
    '';
  };
}

