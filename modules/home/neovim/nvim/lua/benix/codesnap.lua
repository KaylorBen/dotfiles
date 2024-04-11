local M = {
  "mistricky/codesnap.nvim",
  build = "make",
}

function M.config()
  require("codesnap").setup({
    mac_window_bar = false,
    code_font_family = "Fira Code",
    watermark_font_family = "Fantasque Sans Mono",
    has_breadcrumbs = true,
  })
end

return M;
