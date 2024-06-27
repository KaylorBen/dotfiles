{ self, nix-citizen, hyprland, xdg-desktop-portal-hyprland, picom, ... }:

_prev: super: {
  inherit (self.packages.${super.system}) fflogs wowup oxce-plus;
  inherit (nix-citizen.packages.${super.system})
    lug-helper star-citizen-helper star-citizen;
  # wezterm = wezterm.packages.${super.system}.default;
  # hyprland = hyprland.packages.${super.system}.hyprland;
  # xdg-desktop-portal-hyprland = xdg-desktop-portal-hyprland.packages.${super.system}.xdg-desktop-portal-hyprland;
  picom = picom.defaultPackage.${super.system};

  # discord = super.discord.override {
  #   withOpenASAR = true;
  #   withVencord = true;
  # };

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

  xivlauncher = self.packages.${super.system}.xlcore-git.overrideAttrs (old: {
    runtimeDeps = [ super.gamemode super.gamescope ] ++ old.runtimeDeps;
  });
}
