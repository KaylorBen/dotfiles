local M = {
  "ThePrimeagen/harpoon",
}

function M.config()
  local wk = require("which-key")
  wk.register {
    ["<leader>Hm"] = { "<cmd>lua require('harpoon.mark').add_file()", "Mark File" },
    ["<leader>Hv"] = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()", "Toggle Menu" },
    ["<leader>Hn"] = { "<cmd>lua require('harpoon.ui').nav_next()", "Next File" },
    ["<leader>Hp"] = { "<cmd>lua require('harpoon.ui').nav_prev()", "Previous File" },

    ["<leader>H1"] = { "<cmd>lua require('harpoon.ui').nav_file(1)", "Jump to File 1" },
    ["<leader>H2"] = { "<cmd>lua require('harpoon.ui').nav_file(2)", "Jump to File 2" },
    ["<leader>H3"] = { "<cmd>lua require('harpoon.ui').nav_file(3)", "Jump to File 3" },
    ["<leader>H4"] = { "<cmd>lua require('harpoon.ui').nav_file(4)", "Jump to File 4" },
    ["<leader>H5"] = { "<cmd>lua require('harpoon.ui').nav_file(5)", "Jump to File 5" },
    ["<leader>H6"] = { "<cmd>lua require('harpoon.ui').nav_file(6)", "Jump to File 6" },
    ["<leader>H7"] = { "<cmd>lua require('harpoon.ui').nav_file(7)", "Jump to File 7" },
    ["<leader>H8"] = { "<cmd>lua require('harpoon.ui').nav_file(8)", "Jump to File 8" },
    ["<leader>H9"] = { "<cmd>lua require('harpoon.ui').nav_file(9)", "Jump to File 9" },
  }

  require("harpoon").setup({
    save_on_toggle = false,
    save_on_change = true,
  })
end

return M
