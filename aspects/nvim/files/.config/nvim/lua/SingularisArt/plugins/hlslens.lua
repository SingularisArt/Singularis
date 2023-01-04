vim.cmd([[noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR> <Cmd>lua require('hlslens').start()<CR>]])
vim.cmd([[noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR> <Cmd>lua require('hlslens').start()<CR>]])
vim.cmd([[noremap * *<Cmd>lua require('hlslens').start()<CR>]])
vim.cmd([[noremap # #<Cmd>lua require('hlslens').start()<CR>]])
vim.cmd([[noremap g* g*<Cmd>lua require('hlslens').start()<CR>]])
vim.cmd([[noremap g# g#<Cmd>lua require('hlslens').start()<CR>]])
vim.cmd([[nnoremap <silent> <leader>l :noh<CR>]])
require("hlslens").setup({
  calm_down = true,
  nearest_float_when = "always",
})
vim.cmd([[aug VMlens]])
vim.cmd([[au!]])
vim.cmd([[au User visual_multi_start lua require('utils.vmlens').start()]])
vim.cmd([[au User visual_multi_exit lua require('utils.vmlens').exit()]])
vim.cmd([[aug END]])
