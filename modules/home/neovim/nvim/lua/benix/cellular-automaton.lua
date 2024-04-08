local M = {
  "Eandrju/cellular-automaton.nvim",
}

function M.config()
  local wk = require("which-key")
  wk.register {
    ["<leader>!"] = { "<cmd>CellularAutomaton make_it_rain<cr>", "Code be Gone" },
  }
end

return M
