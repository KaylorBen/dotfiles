{ modulesPath, inputs, ... }:
let
  inherit (inputs) nixos-wsl;
in
{
  imports = [
    "${modulesPath}/profiles/minimal.nix"

    nixos-wsl.nixosModules.wsl
  ];

  wsl = {
    enable = true;
    wslConf = {
      automount = {
        root = "/mnt";
      };
    };
    nativeSystemd = true;
    defaultUser = "ben";
    startMenuLaunchers = true;
    interop.register = true;
  };
  networking.hostName = "Lohengrin";
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
    "x86_64-windows"
    "wasm32-wasi"
    "wasm64-wasi"
  ];
}
