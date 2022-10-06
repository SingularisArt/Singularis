local which_key = require("which-key")
local options = SingularisArt.which_key.opts

options = vim.tbl_deep_extend("force", {
  filetype = "rust",
  buffer = vim.api.nvim_get_current_buf(),
}, options)

which_key.register({
  ["L"] = {
    name = "Language",
    p = { "<cmd>MarkdownPreviewToggle<CR>", "Toggle Markdown Preview" },
  },
}, options)
