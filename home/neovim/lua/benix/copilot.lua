local M = {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  dependencies = {
    "zbirenbaum/copilot-cmp"
  }
}

function M.config()
  local wk = require "which-key"
  wk.register {
    name = "Copilot",
    ["<leader>ce"] = { "<cmd>Copilot enable<cr>", "Copilot Enable" },
    ["<leader>cd"] = { "<cmd>Copilot disable<cr>", "Copilot Disable" },
  }
  require("copilot").setup {
    panel = {
      keymap = {
        jump_next = "<c-N>",
        jump_prev = "<c-P>",
        accept = "<c-Y>",
        refresh = "r",
        open = "<M-CR>",
      },
    },
    suggestion = {
      enable = true,
      auto_trigger = true,
      keymap = {
        accept = "<c-Y>",
        next = "<c-N>",
        prev = "<c-P>",
        dismiss = "<c-E>",
      },
    },
    filetypes = {
      markdown = false,
      help = false,
      gitcommit = false,
      gitrebase = false,
      hgcommit = false,
      svn = false,
      csv = false,
      ["."] = false,
    },
  }

  require("copilot_cmp").setup()
end

return M
