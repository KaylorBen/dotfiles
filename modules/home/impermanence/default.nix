{ config, lib, osConfig, inputs, ... }:
{
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

  config = lib.mkIf config.Wotan.impermanence.enable { };
}
