local which_key = require("which-key")
local options = require("config.global").which_key_vars.options
local voptions = require("config.global").which_key_vars.voptions

options = vim.tbl_deep_extend("force", {
  filetype = "python",
  buffer = vim.api.nvim_get_current_buf(),
}, options)

which_key.register({
  ["L"] = {
    name = "Language",
    j = {
      name = "Jupyter",
      l = { "<Cmd>MoltenLoad<CR>", "Load Molten" },
      i = { "<Cmd>MoltenInit<CR>", "Init Molten" },
      I = { "<Cmd>MoltenInfo<CR>", "Info Molten" },
      e = { "<Cmd>MoltenEvaluateLine<CR>", "Evaluate Line Molten" },
      r = { "<Cmd>MoltenReevaluateCell<CR>", "Reevaluate Cell Molten" },
    },
    p = { "<Cmd>PyrightOrganizeImports<CR>", "Organize Imports" },
  },
}, options)

which_key.register({
  ["L"] = {
    name = "Language",
    j = {
      name = "Jupyter",
      e = { "<Esc><Cmd>MoltenEvaluateVisual<cr>", "Evaluate Highlighted Line" },
    },
  },
}, voptions)
