{
  programs.nixvim = {
    keymaps = [
      # Better window navigation
      {
        mode = "n";
        key = "<m-h>";
        action = "<C-w>h";
      }
      {
        mode = "n";
        key = "<m-j>";
        action = "<C-w>j";
      }
      {
        mode = "n";
        key = "<m-k>";
        action = "<C-w>k";
      }
      {
        mode = "n";
        key = "<m-l>";
        action = "<C-w>l";
      }
      
      # Stay in indent mode
      {
        mode = "v";
        key = "<";
        action = "<gv";
      }
      {
        mode = "v";
        key = ">";
        action = ">gv";
      }

      # Quick quit
      {
        mode = "n";
        key = "<leader>q";
        action = "<cmd>confirm q<CR>";
      }

      # No highlight
      {
        mode = "n";
        key = "<leader>h";
        action = "<cmd>noh<CR>";
      }

      # Split
      {
        mode = "n";
        key = "<leader>v";
        action = "<cmd>vsplit<CR>";
      }

      # Tab-spacing
      {
        mode = "n";
        key = "<leader>t1";
        action = "<cmd>set tabstop=1<cr><cmd>set shiftwidth=1<cr>";
      }
      {
        mode = "n";
        key = "<leader>t2";
        action = "<cmd>set tabstop=2<cr><cmd>set shiftwidth=2<cr>";
      }
      {
        mode = "n";
        key = "<leader>t3";
        action = "<cmd>set tabstop=3<cr><cmd>set shiftwidth=3<cr>";
      }
      {
        mode = "n";
        key = "<leader>t4";
        action = "<cmd>set tabstop=4<cr><cmd>set shiftwidth=4<cr>";
      }
      {
        mode = "n";
        key = "<leader>t5";
        action = "<cmd>set tabstop=5<cr><cmd>set shiftwidth=5<cr>";
      }
      {
        mode = "n";
        key = "<leader>t6";
        action = "<cmd>set tabstop=6<cr><cmd>set shiftwidth=6<cr>";
      }
      {
        mode = "n";
        key = "<leader>t7";
        action = "<cmd>set tabstop=7<cr><cmd>set shiftwidth=7<cr>";
      }
      {
        mode = "n";
        key = "<leader>t8";
        action = "<cmd>set tabstop=8<cr><cmd>set shiftwidth=8<cr>";
      }

      # nvim-tree
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>NvimTreeToggle<CR>";
      }

      # comment.nvim
      {
        mode = "n";
        key = "<leader>/";
        action = "<Plug>(comment_toggle_linewise_current)";
      }
      {
        mode = "v";
        key = "<leader>/";
        action = "<Plug>(comment_toggle_linewise_visual)";
      }

      # LSP
      {
        mode = "n";
        key = "gD";
        action = "<cmd>lua vim.lsp.buf.decleration()<cr>";
      }
      {
        mode = "n";
        key = "gd";
        action = "<cmd>lua vim.lsp.buf.definition()<cr>";
      }
      {
        mode = "n";
        key = "K";
        action = "<cmd>lua vim.lsp.buf.hover()<cr>";
      }
      {
        mode = "n";
        key = "gI";
        action = "<cmd>lua vim.lsp.buf.implementation()<cr>";
      }
      {
        mode = "n";
        key = "gr";
        action = "<cmd>lua vim.lsp.buf.references()<cr>";
      }
      {
        mode = "n";
        key = "gl";
        action = "<cmd>lua vim.diagnostic.open_float()<cr>";
      }

      # Telescope.nvim
      {
        key = "<leader>fb";
        action = "<cmd>Telescope git_branches<cr>";
      }
      {
        key = "<leader>fc";
        action = "<cmd>Telescope colorscheme<cr>";
      }
      {
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<cr>";
      }
      # { # TODO requires project.nvim
      #   key = "<leader>fp";
      #   action = "<cmd>Telescope <cr>";
      # }
      {
        key = "<leader>ft";
        action = "<cmd>Telescope live_grep<cr>";
      }
      {
        key = "<leader>fs";
        action = "<cmd>Telescope grep_string<cr>";
      }
      {
        key = "<leader>fh";
        action = "<cmd>Telescope help_tags<cr>";
      }
      {
        key = "<leader>fH";
        action = "<cmd>Telescope highlights<cr>";
      }
      {
        key = "<leader>fl";
        action = "<cmd>Telescope resume<cr>";
      }
      {
        key = "<leader>fM";
        action = "<cmd>Telescope man_pages<cr>";
      }
      {
        key = "<leader>fr";
        action = "<cmd>Telescope oldfiles<cr>";
      }
      {
        key = "<leader>fR";
        action = "<cmd>Telescope registers<cr>";
      }
      {
        key = "<leader>fk";
        action = "<cmd>Telescope keymaps<cr>";
      }
      {
        key = "<leader>fC";
        action = "<cmd>Telescope commands<cr>";
      }
      # Telescope Git stuff
      {
        key = "<leader>go";
        action = "<cmd>Telescope git_status<cr>";
      }
      {
        key = "<leader>gb";
        action = "<cmd>Telescope git_branches<cr>";
      }
      {
        key = "<leader>gc";
        action = "<cmd>Telescope git_commits<cr>";
      }
      {
        key = "<leader>gC";
        action = "<cmd>Telescope git_bcommits<cr>";
      }
      # Telescope LSP stuff
      {
        key = "<leader>ls";
        action = "<cmd>Telescope lsp_document_symbols<cr>";
      }
      {
        key = "<leader>lS";
        action = "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>";
      }
      {
        key = "<leader>le";
        action = "<cmd>Telescope quickfix<cr>";
      }
    ];
    plugins.which-key = {
      enable = true;
      registrations = {
        "<leader>q" = "Quit";
        "<leader>h" = "No Highlight";
        "<leader>v" = "Split";
        "<leader>t" = "Tab-spacing";
        "<leader>e" = "Explorer";
        "<leader>/" = "Comment";
        "<leader>f" = "Find";
        "<leader>l" = "LSP";
        "<leader>g" = "Git";
      };
    };
  };
}
