if vim.loader then
  vim.loader.enable()
end

package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.config/luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.config/luarocks/share/lua/5.1/?.lua;"

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config")
vim.cmd("set rtp+=~/Documents/school-notes/current-course")
