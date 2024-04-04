{ self, nix-citizen, wezterm, ... }:

_prev: super: {
  inherit (nix-citizen.packages.${super.system})
    lug-helper star-citizen-helper star-citizen;
  wezterm = wezterm.packages.${super.system}.default;
}
