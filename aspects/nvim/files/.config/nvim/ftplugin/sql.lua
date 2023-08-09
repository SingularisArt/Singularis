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
    u = { "<Cmd>DBUIToggle<Cr>", "Toggle UI" },
    f = { "<Cmd>DBUIFindBuffer<Cr>", "Find buffer" },
    r = { "<Cmd>DBUIRenameBuffer<Cr>", "Rename buffer" },
    q = { "<Cmd>DBUILastQueryInfo<Cr>", "Last query info" },
  },
}, options)
