{ pkgs, lib, stdenv }:
stdenv.mkDerivation {
  pname = "openxcom";
  version = "1.0.0.2024.02.28";

  src = pkgs.fetchFromGitHub {
    owner = "MeridianOXC";
    repo = "OpenXcom";
    rev = "4a98605e9fcb3f9a9ce8c43737d07e938b09bb00";
    hash = "sha256-2G2dSvoDdacdYsXS51h3aGLCCjbHwcvD4CNnQIH/J6A=";
  };

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
  ];

  buildInputs = with pkgs; [
    boost
    libGL
    libGLU
    SDL
    SDL_gfx
    SDL_image
    SDL_mixer
    yaml-cpp
    openssl
    zlib
  ];

  meta = {
    description = "Open source clone of UFO: Enemy Unknown";
    mainProgram = "openxcom";
    homepage = "https://openxcom.org";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
  };
}
