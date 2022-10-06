local which_key = require("which-key")
local options = SingularisArt.which_key.opts
local voptions = SingularisArt.which_key.vopts

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
    e = {
      name = "Virtual Environments",
      i = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Pick Env" },
      d = { "<cmd>lua require('swenv.api').get_current_venv()<cr>", "Show Env" },
    },
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
