{ config, lib, ... }:
{
  options.Wotan.programs.ssh.enable = lib.mkEnableOption "ssh";

  config = lib.mkIf config.Wotan.programs.ssh.enable {
    programs.ssh = {
      enable = true;
      compression = lib.mkDefault true;
      forwardAgent = lib.mkDefault true;
    };
  };
}
