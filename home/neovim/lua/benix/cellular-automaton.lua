local M = {
  "Eandrju/cellular-automaton.nvim",
  lazy = true,
}

function M.config()
  require("cellular-automaton").setup()
end
