{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  home.file.".config/neovim/init.lua".source = "./init.lua";
  home.file = {
    ".config/neovim/lua" = {
      source = ./lua;
      recursive = true;
    };
  };
}
