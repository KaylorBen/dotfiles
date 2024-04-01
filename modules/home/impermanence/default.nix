{ config, lib, osConfig, inputs, ... }:
let cfg = config.Wotan.impermanence;
in {
  imports = with inputs;
    [ impermanence.nixosModules.home-amanger.impermanence ];
  options.Wotan.impermanence = {
    enable = lib.mkOption {
      type = lib.types.bool;
      description = "Impermanence";
      default = if builtins.hasAttr "nebula" osConfig then
        osConfig.Wotan.impermanence.enable
      else
        false;
    };
  };

  config = lib.mkIf cfg.enable { };
}
