local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "andrem222/copilot-lualine"
  },
  -- cond = not vim.g.started_by_firenvim,
}

function M.config()
  require("lualine").setup {
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      ignore_focus = { "nvimtree" },
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'copilot', 'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    extensions = { "quickfix", "man", "fugitive" },
  }
end

return M
