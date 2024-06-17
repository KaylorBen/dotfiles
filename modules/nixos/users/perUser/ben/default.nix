{ config, lib, pkgs, ... }: {
  config = lib.mkIf config.Wotan.users.enable {
    # Define ben
    snowfallorg.users.ben = { };
    users.users.ben = {
      isNormalUser = true;
      # initialPassword = "NixOS4Life";
      extraGroups = [
        "audio"
        "bluetooth"
        "games"
        "libvirtd"
        "podman"
        "pipewire"
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
