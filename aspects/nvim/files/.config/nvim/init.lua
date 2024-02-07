if vim.loader then
  vim.loader.enable()
end

package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.config/luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.config/luarocks/share/lua/5.1/?.lua;"

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config")
vim.cmd("set rtp+=~/Documents/school-notes/current-course")

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
