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

which_key.add({
  { "<Leader>L", group = "Language" },
  { "<Leader>Lu", "<Cmd>DBUIToggle<Cr>", desc = "Toggle UI" },
  { "<Leader>Lf", "<Cmd>DBUIFindBuffer<Cr>", desc = "Find buffer" },
  { "<Leader>Lr", "<Cmd>DBUIRenameBuffer<Cr>", desc = "Rename buffer" },
  { "<Leader>Lq", "<Cmd>DBUILastQueryInfo<Cr>", desc = "Last query info" },
}, options)
