final: prev: {
  myLib = import ../lib/default.nix;
  # fonts = (
  #   prev.nerdfonts.override {
  #     fonts = [
  #       "FantasqueSansMono"
  #       "FiraCode"
  #       "FiraMono"
  #     ];
  #   }
  # );
}

# final: prev: {
#   inherit (self.packages.${prev.system}) oxce-plus;
#   inherit (nix-citizen.packages.${prev.system})
#     lug-helper
#     star-citizen-helper
#     star-citizen
#     ;
#   picom = picom.defaultPackage.${prev.system};
#   xivlauncher-rb = nixos-xivlauncher-rb.packages.${prev.system}.default;
#
#   # _7zz = stable-nixpkgs.legacyPackages.${prev.system}._7zz;
#   cava = stable-nixpkgs.legacyPackages.${prev.system}.cava;
#
#
#   # lib = prev.lib // import ../lib/default.nix;
#
#   lutris = prev.lutris.override {
#     steamSupport = true;
#     extraPkgs = _pkgs: [
#       prev.winetricks
#       prev.gamescope
#       prev.goverlay
#       prev.gamemode
#     ];
#     extraLibraries = _pkgs: [ prev.mangohud ];
#   };
# }
