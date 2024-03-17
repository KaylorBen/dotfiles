{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./plugins
    ./autoCmd.nix
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
