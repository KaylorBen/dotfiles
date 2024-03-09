{ flake-self, lib, ... }:
inputs: self: super: {
  fflogs =
    super.callPackage ./packages/fflogs { };
}
