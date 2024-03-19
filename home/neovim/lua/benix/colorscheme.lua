local M = {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
}

function M.config()
  vim.cmd.colorscheme("gruvbox")
end

return M
