{
  description = "Jupyter development environment";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = [ pkgs.bashInteractive ];
          buildInputs = with pkgs;
            [
              # Defines a python + set of packages.
              (python3.withPackages (ps:
                with ps;
                with python3Packages; [
                  jupyter
                  ipython

                  # Uncomment the following lines to make them available in the shell.
                  pandas
                  numpy
                  matplotlib
                ]))
            ];

          shellHook = ''
            echo "`${pkgs.python3}/bin/python --version`"
          '';
        };
      });
}
