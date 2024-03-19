local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
    "nvim-lua/plenary.nvim",
  },
}

function M.config()
  local wk = require "which-key"
  wk.register {
    ["<leader>fb"] = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    ["<leader>fc"] = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find files" },
    ["<leader>fp"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
    ["<leader>ft"] = { "<cmd>Telescope live_grep<cr>", "Find Text" },
    ["<leader>fs"] = { "<cmd>Telescope grep_string<cr>", "Find String" },
    ["<leader>fh"] = { "<cmd>Telescope help_tags<cr>", "Help" },
    ["<leader>fH"] = { "<cmd>Telescope highlights<cr>", "Highlights" },
    ["<leader>fi"] = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
    ["<leader>fl"] = { "<cmd>Telescope resume<cr>", "Last Search" },
    ["<leader>fM"] = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
    ["<leader>fR"] = { "<cmd>Telescope registers<cr>", "Registers" },
    ["<leader>fk"] = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    ["<leader>fC"] = { "<cmd>Telescope commands<cr>", "Commands" },

    ["<leader>go"] = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    ["<leader>gb"] = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    ["<leader>gc"] = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    ["<leader>gC"] = {
      "<cmd>Telescope git_bcommits<cr>",
      "Checkout commit(for current file)",
    },

    ["<leader>ls"] = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    ["<leader>lS"] = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
    ["<leader>le"] = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
  }

  local icons = require "benix.icons"
  local actions = require "telescope.actions"

  require("telescope").setup {
    defaults = {
      prompt_prefix = icons.ui.Telescope .. " ",
      selection_caret = icons.ui.Forward .. " ",
      entry_prefix = "   ",
      initial_mode = "insert",
      selection_strategy = "reset",
      path_display = { "smart" },
      color_devicons = true,

      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,

          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
        n = {
          ["<esc>"] = actions.close,
          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["q"] = actions.close,
        },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      },
    },
  }
end

return M
