{
  description = "Zig development environment";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.default = pkgs.mkShell {
        nativeBuildInputs = [ pkgs.bashInteractive ];
        buildInputs = with pkgs; [
          zig
          zls
        ];

        shellHook = ''
          echo "`${pkgs.zig}/bin/zig --version`"
          echo "`${pkgs.zls}/bin/zls --version`"
        '';
      };
    });
}
