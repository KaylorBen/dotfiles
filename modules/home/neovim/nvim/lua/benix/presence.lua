local M = {
	"andweeb/presence.nvim",
}

function M.config()
	require("presence").setup({
		enable_line_number = true,
	})
end

return M
