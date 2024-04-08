local M = {
  "rose-pine/neovim",
  lazy = false,
  priority = 1000,
}

function M.config()
  require("rose-pine").setup()
  vim.cmd.colorscheme("rose-pine")
end

return M
