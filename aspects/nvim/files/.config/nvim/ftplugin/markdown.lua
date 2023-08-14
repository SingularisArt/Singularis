local which_key = require("which-key")
local options = require("config.global").which_key_vars.options
local buffer = vim.api.nvim_get_current_buf()

options = vim.tbl_deep_extend("force", {
  filetype = "markdown",
  buffer = buffer,
}, options)

which_key.register({
  ["L"] = {
    name = "Language",
    g = { "<cmd>Glow<CR>", "Toggle Glow" },
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

vim.keymap.set(
  "n", "<C-i>", ":lua require(\"markdowny\").italic()<CR>",
  { buffer = buffer }
)
vim.keymap.set(
  "n", "<C-b>", ":lua require(\"markdowny\").bold()<CR>",
  { buffer = buffer }
)
vim.keymap.set(
  "n", "<C-K>", ":lua require(\"markdowny\").link()<CR>",
  { buffer = buffer }
)
