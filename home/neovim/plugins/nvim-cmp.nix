{
  programs.nixvim.plugins = {
    nvim-cmp = {
      enable = true;
      snippet.expand = "luasnip";
      mapping = {
        "<C-k>" = {
          action = "cmp.mapping.select_prev_item()";
          modes = [ "i" "c" ];
        }; 
        "<C-j>" = {
          action = "cmp.mapping.select_next_item()";
          modes = [ "i" "c" ];
        }; 
        "<Down>" = {
          action = "cmp.mapping.select_prev_item()";
          modes = [ "i" "c" ];
        }; 
        "<Up>" = {
          action = "cmp.mapping.select_next_item()";
          modes = [ "i" "c" ];
        }; 
        "<C-b>" = {
          action = "cmp.mapping.scroll_docs(-1)";
          modes = [ "i" "c" ];
        }; 
        "<C-f>" = {
          action = "cmp.mapping.scroll_docs(1)";
          modes = [ "i" "c" ];
        }; 
        "<C-Space>" = {
          action = "cmp.mapping.complete()";
          modes = [ "i" "c" ];
        }; 
        "<C-e>" = {
          action = "cmp.mapping.abort()";
          modes = [ "i" "c" ];
        };
        "<CR>" = "cmp.mapping.confirm()";
        "<Tab>" = "cmp.mapping.select_next_item()";
      };
      sources = [
        { name = "nvim_lsp"; }
        { name = "luasnip"; }
        { name = "path"; }
      ];
    };
    cmp_luasnip.enable = true;
    luasnip.enable = true;
  };
}
