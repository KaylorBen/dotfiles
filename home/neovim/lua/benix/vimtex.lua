local M = {
  "lervag/vimtex",
}

function M.init()
  vim.g.text_flavor = 'latex'
  vim.g.vimtex_view_method = 'zathura'
  vim.g.vimtex_quickfix_mode = 0
  vim.wo.conceallevel = 1
  vim.g.tex_conceal= 'adbdmg'
end

return M
