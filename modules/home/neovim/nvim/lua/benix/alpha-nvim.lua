local M = {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"nvim-lua/plenary.nvim",
	},
}

function M.config()
	require("alpha").setup(require("alpha.themes.dashboard").config)
end

return M
