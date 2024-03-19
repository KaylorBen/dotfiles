local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
}

function M.config()
  local mappings = {
    q = { "<cmd>confirm q<CR>", "Quit" },
    h = { "<cmd>nohlsearch<CR>", "NOHL" },
    v = { "<cmd>vsplit<CR>", "Split" },
    b = { name = "Buffers" },
    d = { name = "Debug" },
    f = { name = "Find"},
    g = { name = "Git" },
    l = { name = "LSP" },
    p = { name = "Plugins" },
    c = { name = "Copilot"},
    a = {
      name = "Tab",
      n = { "<cmd>$tabnew<cr>", "New Empty Tab" },
      N = { "<cmd>tabnew %<cr>", "New Tab" },
      o = { "<cmd>tabonly<cr>", "Only" },
      h = { "<cmd>-tabmove<cr>", "Move Left" },
      l = { "<cmd>+tabmove<cr>", "Move Right" },
    },
    t = {
      name = "Tab-Spacing",
      ["1"] = { "<cmd>set tabstop=1<cr><cmd>set shiftwidth=1<cr>", "1" },
      ["2"] = { "<cmd>set tabstop=2<cr><cmd>set shiftwidth=2<cr>", "2" },
      ["3"] = { "<cmd>set tabstop=3<cr><cmd>set shiftwidth=3<cr>", "3" },
      ["4"] = { "<cmd>set tabstop=4<cr><cmd>set shiftwidth=4<cr>", "4" },
      ["5"] = { "<cmd>set tabstop=5<cr><cmd>set shiftwidth=5<cr>", "5" },
      ["6"] = { "<cmd>set tabstop=6<cr><cmd>set shiftwidth=6<cr>", "6" },
      ["7"] = { "<cmd>set tabstop=7<cr><cmd>set shiftwidth=7<cr>", "7" },
      ["8"] = { "<cmd>set tabstop=8<cr><cmd>set shiftwidth=8<cr>", "8" },
    },
    T = { name = "Treesitter" },
  }

  local which_key = require "which-key"

  which_key.setup {
    plugins = {
      marks = true, -- shows a list of your marks on ' and `
      registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    },
    window = {
      border = "single", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    show_help = true, -- show help message on the command line when the popup is visible
    show_keys = true, -- show the currently pressed key and its label as a message in the command line
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
  }

  local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
  }

  which_key.register(mappings, opts)
end

return M

