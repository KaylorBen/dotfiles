{ lib
, pkgs
}:

let
  pname = "fflogs";
  version = "8.3.20";
  src = pkgs.fetchurl {
    url = "https://github.com/RPGLogs/Uploaders-fflogs/releases/download/v${version}/fflogs-v${version}.AppImage";
    sha256 = "d8GvHaUxQgrW4VvT+Wq5sZaKttWL+xkDnPPGmdr5YZg=";
  };
  extracted = pkgs.appimageTools.extractType2 { inherit pname version src; };
in
pkgs.appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    mkdir -p $out/share/applications
    cp -r ${extracted}/usr/share/icons $out/share/
    cp ${extracted}/fflogs.desktop $out/share/applications/
    sed -i s@^Exec=.\*@Exec=$out/bin/${pname}-${version}@g $out/share/applications/fflogs.desktop
  '';

  meta = with lib; {
    description = "An application for uploading Final Fantasy XIV combat logs to fflogs.com";
    homepage = "https://www.fflogs.com/client/download";
    downloadPage = "https://github.com/RPGLogs/Uploaders-fflogs/releases/latest";
    license = licenses.free; # no license listed
    mainProgram = "fflogs";
    platforms = platforms.linux;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}
