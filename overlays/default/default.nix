{
  self,
  nix-citizen,
  hyprland,
  xdg-desktop-portal-hyprland,
  picom,
  nixos-xivlauncher-rb,
  ...
}:

_prev: super: {
  inherit (self.packages.${super.system}) oxce-plus;
  inherit (nix-citizen.packages.${super.system})
    lug-helper
    star-citizen-helper
    star-citizen
    ;
  # wezterm = wezterm.packages.${super.system}.default;
  # hyprland = hyprland.packages.${super.system}.hyprland;
  # xdg-desktop-portal-hyprland = xdg-desktop-portal-hyprland.packages.${super.system}.xdg-desktop-portal-hyprland;
  picom = picom.defaultPackage.${super.system};
  xivlauncher-rb = nixos-xivlauncher-rb.packages.${super.system}.default;

  fonts = (
    super.nerdfonts.override {
      fonts = [
        "FantasqueSansMono"
        "FiraCode"
        "FiraMono"
      ];
    }
  );

  lutris = super.lutris.override {
    steamSupport = true;
    extraPkgs = _pkgs: [
      super.winetricks
      super.gamescope
      super.goverlay
      super.gamemode
    ];
    extraLibraries = _pkgs: [ super.mangohud ];
  };
}
