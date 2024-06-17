local M = {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
}

function M.config()
	local wk = require("which-key")
	wk.register({
		["<leader>lf"] = { "<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<cr>", "Format" },
	})
	require("conform").setup({
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				nix = { "nixfmt" },
			},
		},
	})
end

return M
