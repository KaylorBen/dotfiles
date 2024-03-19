{pkgs, ...}:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      gcc
      nodejs_21
      lua-language-server
      nil
    ];
  };
  home.file.".config/nvim/init.lua".source = ./init.lua;
  home.file = {
    ".config/nvim/lua" = {
      source = ./lua;
      recursive = true;
    };
  };
}
