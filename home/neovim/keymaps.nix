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
    ];
    plugins.which-key = {
      enable = true;
      registrations = {
        "<leader>q" = "Quit";
        "<leader>h" = "No Highlight";
        "<leader>v" = "Split";
        "<leader>t" = "Tab-spacing";
        "<leader>e" = "Explorer";
        "<keader>/" = "Comment";
      };
    };
  };
}
