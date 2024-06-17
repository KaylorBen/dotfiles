local M = {
	"mistricky/codesnap.nvim",
	build = "make",
}

function M.config()
	require("codesnap").setup({
		mac_window_bar = false,
		watermark_font_family = "Fantasque Sans Mono",
		bg_color = "#6e6a86",
		has_breadcrumbs = true,
	})
end

return M
