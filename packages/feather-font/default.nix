{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "feather-font";
  version = "1";

  src = ./.;

  installPhase = ''
    runHook preInstall

    install -Dm644 *.ttf -t $out/share/fonts/truetype

    runHook postInstall
  '';
}
