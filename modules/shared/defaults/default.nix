{ config, pkgs, lib, inputs, ... }:
{
  # Defaults to true
  options.TM.defaults.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable nebula base defaults";
  };

  config = lib.mkIf config.Wotan.defaults.enable {
    nix = {
      # registry.nixpkgs.flake = inputs.nixpkgs;
      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        auto-optimise-store = pkgs.stdenv.isLinux;
      };
    };
  };
}
