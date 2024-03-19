local M = {
  "lukas-reineke/indent-blankline.nvim",
  event = "VeryLazy",
  main = "ibl",
  opts = {},
}

function M.config()
  local icons = require "ben.icons"

  require("ibl").setup {
    exclude = {
      filetypes = {
      "help",
      "startify",
      "dashboard",
      "lazy",
      "neogitstatus",
      "NvimTree",
      "Trouble",
      "text",
      },
      buftypes = {
        "terminal",
        "nofile",
      },
    },
    indent = {
      char = icons.ui.LineMiddle,
      tab_char = icons.ui.LineMiddle,
    },
    whitespace = {
      remove_blankline_trail = false,
    },
  }
end

return M
