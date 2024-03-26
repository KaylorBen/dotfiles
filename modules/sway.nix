{ pkgs, ... }:
{
  programs.sway.enable = true;
  environment.systemPackages = with pkgs; [
    dmenu
    wmenu
  ];
}
