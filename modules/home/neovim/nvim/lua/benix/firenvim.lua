local M = {
	"glacambre/firenvim",

	lazy = not vim.g.started_by_firenvim,
	build = function()
		vim.fn["firenvim#install"](0)
	end,
}

function M.config() end

return M
