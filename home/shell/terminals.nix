{ pkgs, ... }:

{
  programs.kitty = { # GPU accelerated terminal emulator
    enable = true;
    font = {
      package = pkgs.nerdfonts;
      name = "IosevkaTermSlab Nerd Font";
    };
    theme = "Nord";
    settings = {
      background_image_layout = "cscaled";
      background_tint = "0.2";
    };
  };
}
