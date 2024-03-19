{
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      servers = {
        nil_ls.enable = true;
        zls.enable = true;
        nushell.enable = true;
        lua-ls.enable = true;
        rust-analyzer = {
          enable = true;
          installRustc = true;
          installCargo = true;
        };
      };
    };
    # none-ls = {
    #   enable = true;
    # sources = {
    #   formatting = {
    #     stylua.enable = true;
    #     prettier.enable = true;
    #   };
    #   diagnostics.flake8.enable = true;
    # };
    # };
  };
}
