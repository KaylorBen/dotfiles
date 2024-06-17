local M = {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	dependancies = {
		"nvim-treesitter/nvim-treesitter-refactor",
		"nushell/tree-sitter-nu",
	},
}

function M.config()
	local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"c",
			"cpp",
			"cmake",
			"make",
			"lua",
			"markdown",
			"markdown_inline",
			"bash",
			"python",
			"java",
			"zig",
			"rust",
			"go",
			"nix",
			"nu",
		}, -- put the language you want in this array
		highlight = { enable = true },
		indent = { enable = true },
		refactor = {
			smart_rename = {
				enable = true,
				keymaps = {
					smart_rename = "gR",
				},
			},
		},
	})
	parser_config.pdx = {
		install_info = {
			url = "~/Development/tree-sitter-paradox/", -- local path or git repo
			files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
			-- optional entries:
			-- branch = "main", -- default branch in case of git repo if different from master
			generate_requires_npm = false, -- if stand-alone parser without npm dependencies
			requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
		},
		filetype = "txt", -- if filetype does not match the parser name
	}
end

return M
