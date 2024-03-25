{
  description = "Rust development environment";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.default = pkgs.mkShell {
        RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";

        nativeBuildInputs = [ pkgs.bashInteractive ];
        buildInputs = with pkgs; [
          cargo
          rustc
          rust-analyzer
          rustfmt
          clippy
        ];

        shellHook = ''
          echo "`${pkgs.cargo}/bin/cargo --version`"
          echo "`${pkgs.rustc}/bin/rustc --version`"
          echo "`${pkgs.rust-analyzer}/bin/rust-analyzer --version`"
        '';
      };
    });
}
