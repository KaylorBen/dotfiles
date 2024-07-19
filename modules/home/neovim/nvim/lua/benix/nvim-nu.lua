local M = {
	"LhKipp/nvim-nu",
	ft = "nu",

  dependencies = {
    "nvimtools/none-ls.nvim"
  },
}

function M.config()
  vim.cmd("TSInstall nu")
  require("null_ls").setup()
	require("nu").setup()
end

return M
