{ config, lib, inputs, ... }:
with lib;
let cfg = config.Wotan.programs.nix-index;
in {
  options.Wotan.programs.nix-index.enable =
    mkEnableOption "A files database for nixpkgs" // {
      default = true;
    };
  imports = [ inputs.nix-index-database.hmModules.nix-index ];
  config = mkIf cfg.enable {
    programs.nix-index.enable = true;
    programs.nix-index-database.comma.enable = true;
  };
}
