local which_key = require("which-key")
local options = require("config.global").which_key_vars.options

vim.opt.wrap = true
vim.opt.tw = 0
vim.opt.spell = true

vim.cmd([[
  setl omnifunc=mailcomplete#Complete
  autocmd TermOpen * setl nonumber norelativenumber laststatus=0
]])

vim.api.nvim_set_keymap("n", "<Leader>x", ":wq<CR>",  { noremap = true, silent = true })

options = vim.tbl_deep_extend("force", {
  filetype = "mail",
  buffer = vim.api.nvim_get_current_buf(),
}, options)

which_key.add({
  { "<Leader>L", group = "Language" },
  { "<Leader>Lf", "1G0f:C: ", desc = "From" },
  { "<Leader>Lt", "2G0f:C: ", desc = "To" },
  { "<Leader>Lc", "3G0f:C: ", desc = "CC" },
  { "<Leader>Lb", "4G0f:C: ", desc = "BCC" },
  { "<Leader>Ls", "5G0f:C: ", desc = "Subject" },
  { "<Leader>Lr", "6G0f:C: ", desc = "Reply To" },
}, options)
