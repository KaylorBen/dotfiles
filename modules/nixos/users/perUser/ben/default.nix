{ config, lib, pkgs, ... }:
let cfg = config.Wotan.users;
in {
  config = lib.mkIf cfg.enable {
    # Define ben
    snowfallorg.users.ben = { };
    users.users.ben = {
      isNormalUser = true;
      initialPassword = "NixOS4Life";
      extraGroups = [
        "audio"
        "bluetooth"
        "games"
        "libvirtd"
        "podman"
        "ssh"
        "tss"
        "video"
        "virtualization"
        "wheel"
      ];
      shell = lib.mkForce pkgs.nushell;
      description = "Benjamin Kaylor";
      openssh.authorizedKeys.keyFiles = lib.Wotan.get-ssh-key-files "ben";
    };
  };
}
