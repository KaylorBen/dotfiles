{
  pkgs,
  lib,
  stdenv,
}:
stdenv.mkDerivation {
  pname = "oxce-plus";
  version = "7.12";

  src = pkgs.fetchFromGitHub {
    owner = "MeridianOXC";
    repo = "OpenXcom";
    rev = "1bde457c85a96993ba0210ee62a361872554bd9b";
    hash = "sha256-g+v5sfxLNksobrhhxQ/hAlla+LmfLtK6BEBDRmkp6Z4=";
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

  extraInstallCommands = ''
    mkdir -p $HOME/.local/share/openxcom
    ln -s $out/share/openxcom/common $HOME/.local/share/openxcom/common
    ln -s $out/share/openxcom/standard $HOME/.local/share/openxcom/standard
  '';

  meta = {
    description = "Open source clone of UFO: Enemy Unknown";
    mainProgram = "openxcom";
    homepage = "https://openxcom.org";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
  };
}
