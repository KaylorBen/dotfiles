{ self
, nix-citizen
, wezterm
, hyprland
, xdg-desktop-portal-hyprland
, picom
, ... }:

_prev: super: {
  inherit (nix-citizen.packages.${super.system})
    lug-helper star-citizen-helper star-citizen;
  wezterm = wezterm.packages.${super.system}.default;
  hyprland = hyprland.packages.${super.system}.hyprland;
  xdg-desktop-portal-hyprland = xdg-desktop-portal-hyprland.packages.${super.system}.xdg-desktop-portal-hyprland;
  picom = picom.defaultPackage.${super.system};
}
