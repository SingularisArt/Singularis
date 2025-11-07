if vim.g.isInkscape then
  return function(_use) end
end

require("config.options").tex()

local opts = require("config.global").opts
local keymap = require("config.global").keymap

keymap(
  "n",
  "<C-f>",
  ":silent exec '!~/Documents/inkscape-figure-manager/main.py edit \"'.b:vimtex.root.'/figures/\" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>",
  opts,
  "Search and edit figures."
)

keymap(
  "i",
  "<C-f>",
  "<Esc>: silent exec '.!~/Documents/inkscape-figure-manager/main.py create \"'.getline('.').'\" \"'.b:vimtex.root.'/figures/\"'<CR><CR>:w<CR>",
  opts,
  "Create new figure."
)
