local which_key = require("which-key")
local options = require("config.global").which_key_vars.options
local buffer = vim.api.nvim_get_current_buf()

options = vim.tbl_deep_extend("force", {
  filetype = "markdown",
  buffer = buffer,
}, options)

which_key.add({
  { "<Leader>L", group = "Language" },
  { "<Leader>Lg", "<CMD>Glow<CR>", desc = "Toggle Glow" },
  { "<Leader>Lp", "<CMD>MarkdownPreviewToggle<CR>", desc = "Toggle Markdown Preview" },

  { "<Leader>Lt", group = "Table" },
  { "<Leader>Ltt", "<CMD>TableModeToggle<CR>", desc = "Enable/Disable Table Mode" },
  { "<Leader>Ltn", "<Leader>ti", desc = "Get cell info" },

  { "<Leader>Lf", group = "Formula" },
  { "<Leader>Lfa", "<CMD>TableAddFormula<CR>", desc = "Add formula" },
  { "<Leader>Lfe", "<Leader>tfe", desc = "Evaluate formula on current row" },

  { "<Leader>Ld", group = "Delete" },
  { "<Leader>Ldr", "<Leader>tdr", desc = "Delete row" },
  { "<Leader>Ldc", "<Leader>tdc", desc = "Delete column" },

  { "<Leader>Li", group = "Insert" },
  { "<Leader>Lic", "<Leader>tic", desc = "Insert column" },
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
