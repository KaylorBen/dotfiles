local M = {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    dependancies = {
        "nvim-treesitter/nvim-treesitter-refactor",
    }
}

function M.config()
    require("nvim-treesitter.configs").setup {
        ensure_installed = { "c", "cpp", "cmake", "make", "lua", "markdown", "markdown_inline", "bash", "python", "java", "zig", "rust", "go", "nix" }, -- put the language you want in this array
        highlight = {enable = true},
        indent = {enable = true},
        refactor = {
            smart_rename = {
                enable = true,
                keymaps = {
                    smart_rename = "gR",
                }
            }
        }
    }
end

return M
