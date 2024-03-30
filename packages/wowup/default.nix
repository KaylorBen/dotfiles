{ lib
, pkgs
}:

let
  pname = "wowup";
  version = "2.11.0-beta.4";
  src = pkgs.fetchurl {
    url = "https://github.com/WowUp/WowUp/releases/download/v${version}/WowUp-${version}.AppImage";
    sha256 = lib.fakeSha256;
  };
  extracted = pkgs.appimageTools.extractType2 { inherit pname version src; };
in
pkgs.appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    mkdir -p $out/share/applications
    # cp -r ${extracted}/usr/share/icons $out/share/
    # cp ${extracted}/fflogs.desktop $out/share/applications/
    # sed -i s@^Exec=.\*@Exec=$out/bin/${pname}-${version}@g $out/share/applications/fflogs.desktop
  '';

  meta = with lib; {
    description = "Plugin manager for World of Warcraft addons";
    homepage = "https://wowup.io/";
    downloadPage = "https://github.com/WowUp/WowUp";
    license = licenses.gpl3; # no license listed
    mainProgram = "wowup";
    platforms = platforms.linux;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}
