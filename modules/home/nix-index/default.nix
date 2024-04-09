{ config, lib, inputs, ... }:
{
  options.Wotan.programs.nix-index.enable =
    lib.mkEnableOption "A files database for nixpkgs" // {
      default = true;
    };
  imports = [ inputs.nix-index-database.hmModules.nix-index ];
  config = lib.mkIf config.Wotan.programs.nix-index.enable {
    programs.nix-index.enable = true;
    programs.nix-index-database.comma.enable = true;
  };
}
