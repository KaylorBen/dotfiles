{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./plugins
  ];

  programs = { 
    nixvim = {
      enable = true;

      colorschemes.gruvbox.enable = true;

      enableMan = true;

      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };
    };
  };
}
