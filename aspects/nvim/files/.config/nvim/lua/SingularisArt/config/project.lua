local project = require("project_nvim")

project.setup({
  manual_mode = false,
  detection_methods = { "pattern" },
  patterns = { ".git", "Makefile", "package.json" },
  show_hidden = false,
  silent_chdir = true,
  ignore_lsp = {},
  datapath = vim.fn.stdpath("data"),
})
