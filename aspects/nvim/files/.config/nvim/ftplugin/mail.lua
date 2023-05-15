local which_key = require("which-key")
local options = require("config.global").which_key_vars.options
local voptions = require("config.global").which_key_vars.voptions

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

which_key.register({
  ["L"] = {
    name = "Language",
    f = { "1G0f:C: ", "From" },
    t = { "2G0f:C: ", "To" },
    c = { "3G0f:C: ", "CC" },
    b = { "4G0f:C: ", "BCC" },
    s = { "5G0f:C: ", "Subject" },
    r = { "6G0f:C: ", "Reply To" },
  },
}, options)
