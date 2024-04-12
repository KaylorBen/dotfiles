local M = {
  "mfussenegger/nvim-jdtls",
  dependencies = {
    {
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
    }
  },
  ft = "java",
}

function M.config()
  local home_dir = os.getenv("HOME")
  require('jdtls').start_or_attach({
    cmd = {
      'jdtls',
      '-data',
      home_dir .. '/Development/Mines/SoftwareEngineering-CSCI306/'
    },
    root_dir = vim.fs.dirname(vim.fs.find({'.git'}, { upward = true })[1]),
    settings = {
      signatureHelp = { enabled = true },
      import = { enabled = true },
      rename = { enabled = true }
    }
  })
end

return M
