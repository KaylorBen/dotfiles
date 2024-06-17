local M = {
	"LhKipp/nvim-nu",
	ft = "nu",
}

function M.config()
	require("nu").setup()
end

return M
