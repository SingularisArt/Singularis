local which_key = require("which-key")
local options = require("config.global").which_key_vars.options
local voptions = require("config.global").which_key_vars.voptions

options = vim.tbl_deep_extend("force", {
  filetype = "python",
  buffer = vim.api.nvim_get_current_buf(),
}, options)

which_key.add({
  { "<Leader>L", group = "Language" },
  { "<Leader>Lp", "<Cmd>PyrightOrganizeImports<CR>", desc = "Organize Imports" },

  { "<Leader>Lj", group = "Jupyter" },
  { "<Leader>Ljl", "<Cmd>MoltenLoad<CR>", desc = "Load Molten" },
  { "<Leader>Lji", "<Cmd>MoltenInit<CR>", desc = "Init Molten" },
  { "<Leader>LjI", "<Cmd>MoltenInfo<CR>", desc = "Info Molten" },
  { "<Leader>Lje", "<Cmd>MoltenEvaluateLine<CR>", desc = "Evaluate Line Molten" },
  { "<Leader>Ljr", "<Cmd>MoltenReevaluateCell<CR>", desc = "Reevaluate Cell Molten" },
}, options)

which_key.add({
  { "<Leader>L", group = "Language" },
  { "<Leader>Lj", group = "Jupyter" },
  { "<Leader>Lje", "<Esc><Cmd>MoltenEvaluateVisual<cr>", desc = "Evaluate Highlighted Line" },
}, voptions)
