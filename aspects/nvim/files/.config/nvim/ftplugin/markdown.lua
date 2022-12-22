local which_key = require("which-key")
local options = _G.which_key.opts

options = vim.tbl_deep_extend("force", {
  filetype = "markdown",
  buffer = vim.api.nvim_get_current_buf(),
}, options)

which_key.register({
  ["L"] = {
    name = "Language",
    p = { "<cmd>MarkdownPreviewToggle<CR>", "Toggle Markdown Preview" },
    t = {
      name = "Table",
      t = { "<cmd>TableModeToggle<CR>", "Enable/Disable Table Mode" },
      n = { "<Leader>ti", "Get cell info" },
      f = {
        name = "Formula",
        a = { "<cmd>TableAddFormula<CR>", "Add formula" },
        e = { "<Leader>tfe", "Evaluate formula on current row" },
      },
      d = {
        name = "Delete",
        r = { "<Leader>tdr", "Delete row" },
        c = { "<Leader>tdc", "Delete column" },
      },
      i = {
        name = "Insert",
        c = { "<Leader>tic", "Insert column" },
      },
    },
  },
}, options)
