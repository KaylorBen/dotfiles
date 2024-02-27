{ pkgs, ... }:
{
  home.packages = [pkgs.gh];

  programs.git = {
    enable = true;

    userName = "Benjamin Kaylor";
    userEmail = "blkaylor22@gmail.com";
  };
}
