{ lib, ... }:
let inherit (lib.snowfall) fs;
in {
  info = {
    url = "https://github.com/KaylorBen/dotfiles/tree/snowfall";
    hostInfo = host: flake: {
      inherit (flake.nixosConfiguations.${host}.config.networking) hostName;
      platform = import (./src/hosts + "/${host}/system.nix");
      extra-platforms =
        flake.nixosConfiguations.${host}.config.nix.settings.extra-platforms or [ ];
        features =
          flake.nixosConfiguations.${host}.config.nix.settings.system-features;
        inherit (flake.nixosConfiguations.${host}.config.system.nixos) tags;
    };
    allHostInfo = flake:
      map (host: lib.Wotan.info.hostInfo host flake)
      (builtins.attrNames flake.nixosConfigurations);
  };
  get-secret-file = file: fs.get-file "secrets/${file}";
  get-shared-module = name: fs.get-file "modules/shared/${name}";
  get-ssh-key-files = user:
    fs.get-files (lib.snowfall.fs.get-file "keys/${user}/ssh");

  stateVersion = {
    nixos = "23.11";
    # This should be the same as nixos
    home = "23.11";
  };
}
