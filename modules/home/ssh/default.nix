{ config, lib, ... }:
let cfg = config.Wotan.programs.ssh;
in {
  options.Wotan.programs.ssh.enable = lib.mkEnableOption "ssh";

  config = lib.mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      compression = lib.mkDefault true;
      forwardAgent = lib.mkDefault true;
    };
  };
}
