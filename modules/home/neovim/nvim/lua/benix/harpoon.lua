local M = {
  "ThePrimeagen/harpoon",
}

function M.config()
  local wk = require("which-key")
  wk.register {
    ["<leader>Hm"] = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Mark File" },
    ["<leader>Hv"] = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Toggle Menu" },
    ["<leader>Hn"] = { "<cmd>lua require('harpoon.ui').nav_next()<cr>", "Next File" },
    ["<leader>Hp"] = { "<cmd>lua require('harpoon.ui').nav_prev()<cr>", "Previous File" },

    ["<leader>H1"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", "Jump to File 1" },
    ["<leader>H2"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", "Jump to File 2" },
    ["<leader>H3"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", "Jump to File 3" },
    ["<leader>H4"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", "Jump to File 4" },
    ["<leader>H5"] = { "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", "Jump to File 5" },
    ["<leader>H6"] = { "<cmd>lua require('harpoon.ui').nav_file(6)<cr>", "Jump to File 6" },
    ["<leader>H7"] = { "<cmd>lua require('harpoon.ui').nav_file(7)<cr>", "Jump to File 7" },
    ["<leader>H8"] = { "<cmd>lua require('harpoon.ui').nav_file(8)<cr>", "Jump to File 8" },
    ["<leader>H9"] = { "<cmd>lua require('harpoon.ui').nav_file(9)<cr>", "Jump to File 9" },
  }

  require("harpoon").setup({
    save_on_toggle = false,
    save_on_change = true,
  })
end

return M
