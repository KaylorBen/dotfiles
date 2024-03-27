{ lib,
  pkgs,
}:

let
  pname = "dezoomify-rs";
  version = "2.11.2";
in pkgs.rustPlatform.buildRustPackage rec {
  inherit pname version;

  src = pkgs.fetchFromGitHub {
    owner = "lovasoa";
    repo = pname;
    rev = "v${version}";
    sha256 = lib.fakeSha256;
  };

  cargoSha256 = lib.fakeSha256;

  meta = with lib; {
    description = "A tiled image downloader written in Rust";
    homepage = "https://www.github.com/lovasoa/dezoomify-rs";
    downloadPage = "https://www.github.com/lovasoa/dezoomify-rs/releases/latest";
    platforms = platforms.linux;
    license = licenses.gpl3;
  };
}
