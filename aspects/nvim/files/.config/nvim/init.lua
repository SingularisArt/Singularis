if vim.loader then
  vim.loader.enable()
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config")
vim.cmd("set rtp+=~/Documents/school-notes/current-course")
