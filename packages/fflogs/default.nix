{ lib, pkgs }:

let
  pname = "fflogs";
  version = "8.5.12";
  src = pkgs.fetchurl {
    url =
      "https://github.com/RPGLogs/Uploaders-fflogs/releases/download/v${version}/fflogs-v${version}.AppImage";
    sha256 = "sha256-mlqQm9o001+pSMfMbOwa+gKcIIC6SBg7Rott9+XkB2E=";
  };
  extracted = pkgs.appimageTools.extractType2 { inherit pname version src; };
in pkgs.appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    mkdir -p $out/share/applications
    cp -r ${extracted}/usr/share/icons $out/share/
    cp ${extracted}/fflogs.desktop $out/share/applications/
    sed -i s@^Exec=.\*@Exec=$out/bin/${pname}@g $out/share/applications/fflogs.desktop
  '';

  meta = with lib; {
    description =
      "An application for uploading Final Fantasy XIV combat logs to fflogs.com";
    homepage = "https://www.fflogs.com/client/download";
    downloadPage =
      "https://github.com/RPGLogs/Uploaders-fflogs/releases/latest";
    license = licenses.unfreeRedistributable; # no license listed
    mainProgram = "fflogs";
    platforms = platforms.linux;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}
