_: {
  # Project root
  projectRootFile = "flake.nix";
  # Terraform formatter
  programs = {
    nixfmt.enable = true;
    stylua.enable = true;
    yamlfmt.enable = true;
    #   deno.enable = true;
    #   deadnix = {
    #     enable = true;
    #     # Can break callPackage if this is set to false
    #     no-lambda-pattern-names = true;
    #   };
    #   statix.enable = true;
    #   rustfmt.enable = true;
  };
}
