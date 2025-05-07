vim.g.isLATEX = true
vim.g.isInkscape = false

if vim.loader then
  vim.loader.enable()
end

if not vim.g.isLATEX and vim.g.isInkscape then
  package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.config/luarocks/share/lua/5.1/?/init.lua;"
  package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.config/luarocks/share/lua/5.1/?.lua;"
end

require("config")

if vim.g.isLATEX or vim.g.isInkscape then
  vim.cmd("set rtp+=~/Documents/school-notes/current-course")
end

if vim.g.isInkscape then
  vim.cmd([[
    inoremap wq <Esc>:wq<CR>
    nnoremap wq :wq<CR>
    inoremap qw <Esc>:wq<CR>
    nnoremap qw :wq<CR>

    " Start insert mode between $$'s
    autocmd BufEnter * startinsert | call cursor(1, 2)

    nnoremap j gj
    nnoremap k gk
  ]])
end
