{
  programs.nixvim.plugins = {
    cmp = {
      enable = true;
      settings = {
        snippet.expand = ''
          function(args)
            require('luasnip').lsp_expand(args.body)
          end
        '';
        mapping = {
          "<C-k>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 'c'})";
          "<C-j>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 'c'})";
          "<Down>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 'c'})";
          "<Up>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 'c'})";
          "<C-b>" = "cmp.mapping(cmp.mapping.scroll_docs(-1), {'i', 'c'})";
          "<C-f>" = "cmp.mapping(cmp.mapping.scroll_docs(1), {'i', 'c'})";
          "<C-Space>" = "cmp.mapping(cmp.mapping.complete(), {'i', 'c'})";
          "<C-e>" = "cmp.mapping(cmp.mapping.abort(), {'i', 'c'})";
          "<CR>" = "cmp.mapping.confirm()";
          "<Tab>" = "cmp.mapping.select_next_item()";
        };
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "path"; }
        ];
      };
    };
    cmp_luasnip.enable = true;
    luasnip.enable = true;
  };
}
