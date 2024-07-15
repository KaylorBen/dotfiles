{ lib, pkgs }:

let
  pname = "wowup";
  version = "2.12.0";
  src = pkgs.fetchurl {
    url =
      "https://github.com/WowUp/WowUp/releases/download/v${version}/WowUp-${version}.AppImage";
    sha256 = "M9KINzQGuRZnWWHen7eOHWftk2ETtbbn6T/GpG/nspU=";
  };
  extracted = pkgs.appimageTools.extractType2 { inherit pname version src; };
in pkgs.appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    mkdir -p $out/share/applications
    cp -r ${extracted}/usr/share/icons $out/share/
    cp ${extracted}/wowup.desktop $out/share/applications/
  '';

  meta = with lib; {
    description = "Plugin manager for World of Warcraft addons";
    homepage = "https://wowup.io/";
    downloadPage = "https://github.com/WowUp/WowUp";
    license = licenses.gpl3;
    mainProgram = "wowup";
    platforms = platforms.linux;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}
