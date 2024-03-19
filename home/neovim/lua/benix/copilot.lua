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
        jump_next = "<m-n>",
        jump_prev = "<m-p>",
        accept = "<m-y>",
        refresh = "r",
        open = "<M-CR>",
      },
    },
    suggestion = {
      enable = true,
      auto_trigger = true,
      keymap = {
        accept = "<m-y>",
        next = "<m-n>",
        prev = "<m-p>",
        dismiss = "<m-e>",
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
