local M = {
  "mfussenegger/nvim-jdtls",
}

local config = {
  cmd = { io.popen("nix path-info nixpkgs#jdt-language-server") },
  root_dir = vim.fs.dirname(vim.fs.find({".git", ".classpath"}, { upward = true })[1]),
}

function M.config()
  require("jdtls").start_or_attach(config)
end

return M
