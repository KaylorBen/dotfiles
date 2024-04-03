{ self, nix-citizen, ... }:

_prev: super: {
  inherit (nix-citizen.packages.${super.system})
    lug-helper star-citizen-helper star-citizen;
}
