local which_key = require("which-key")
local options = require("config.global").which_key_vars.options
local voptions = require("config.global").which_key_vars.voptions

options = vim.tbl_deep_extend("force", {
  filetype = "python",
  buffer = vim.api.nvim_get_current_buf(),
}, options)
voptions = vim.tbl_deep_extend("force", {
  filetype = "python",
  buffer = vim.api.nvim_get_current_buf(),
}, voptions)

which_key.register({
  ["L"] = {
    name = "Language",
    j = {
      name = "Jupyter",
      i = { "<Cmd>MagmaInit<CR>", "Init Magma" },
      d = { "<Cmd>MagmaDeinit<CR>", "Deinit Magma" },
      e = { "<Cmd>MagmaEvaluateLine<CR>", "Evaluate Line" },
      r = { "<Cmd>MagmaReevaluateCell<CR>", "Re evaluate cell" },
      D = { "<Cmd>MagmaDelete<CR>", "Delete cell" },
      s = { "<Cmd>MagmaShowOutput<CR>", "Show Output" },
      R = { "<Cmd>MagmaRestart!<CR>", "Restart Magma" },
      S = { "<Cmd>MagmaSave<CR>", "Save" },
    },
    p = { "<CmdPyrightOrganizeImports<CR>", "Organize Imports" },
  },
}, options)

which_key.register({
  ["L"] = {
    name = "Language",
    j = {
      name = "Jupyter",
      e = { "<esc><cmd>MagmaEvaluateVisual<cr>", "Evaluate Highlighted Line" },
    },
  },
}, voptions)
