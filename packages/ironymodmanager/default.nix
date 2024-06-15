{ pkgs
, lib
}:

pkgs.buildDotnetModule rec {
  pname = "IronyModManager";
  version = "1.26.176";

  src = pkgs.fetchFromGitHub {
    owner = "bcssov";
    repo = pname;
    rev = "v${version}";
    sha256 = lib.fakeSha256;
  };

  projectFile = "src/IronyModManager/IronyModManager.csproj";

  meta = with lib; {
    homepage = "";
    description = "";
    license = licenses.mit;
  };
}
