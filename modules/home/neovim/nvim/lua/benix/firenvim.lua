local M = {
  "glacambre/firenvim",

  lazy = not vim.g.started_by_firenvim,
}

function M.config()
  vim.fn["firenvim#install"](0)
end

return M
