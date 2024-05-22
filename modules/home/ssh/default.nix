{ config, lib, ... }:
with lib;
let cfg = config.Wotan.programs.ssh;
in {
  options.Wotan.programs.ssh.enable = mkEnableOption "ssh";

  config = mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      compression = mkDefault true;
      forwardAgent = mkDefault true;
    };
  };
}
