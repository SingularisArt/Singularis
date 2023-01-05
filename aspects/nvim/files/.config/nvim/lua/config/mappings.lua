local function keymap(mode, binding, action, opts, description)
  opts["desc"] = description

  vim.api.nvim_set_keymap(mode, binding, action, opts)
end

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

keymap("n", "<Space>", "", opts, "")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
keymap("n", "<C-h>", "<C-w>h", opts, "Jump to left split.")
keymap("n", "<C-j>", "<C-w>j", opts, "Jump to below split.")
keymap("n", "<C-k>", "<C-w>k", opts, "Jump to above split.")
keymap("n", "<C-l>", "<C-w>l", opts, "Jump to right split.")
keymap("n", "<Leader><Leader>", "<C-^>", opts, "Jump to previous buffer.")
keymap("n", "n", "nzzzv", opts, "Jump to next search.")
keymap("n", "N", "Nzzzv", opts, "Jump to previous search.")
keymap("n", "J", "mzJ`z", opts, "Concat lines.")
keymap("n", "<Leader>j", ":m . +1<CR>==", opts, "Move line down.")
keymap("n", "<Leader>k", ":m . -2<CR>==", opts, "Move line up.")
keymap("n", "<Leader>v", ":vsplit<CR>", opts, "Create vertical split.")
keymap("n", "<Leader>h", ":split<CR>", opts, "Create horizontal split.")
keymap("n", "<C-w>", ":bdelete<CR>", opts, "Delete buffer.")
keymap("n", "<C-t>", ":tabnew<CR>", opts, "Create new tab.")
keymap("n", "<C-a>", "ggVG", opts, "Highlight everything.")
keymap("n", ";", ":nohl<CR>", opts, "Clear search highlight.")
keymap("n", "<Tab>", "za", opts, "Toggle tab.")
keymap(
  "n",
  "<C-f>",
  ":silent exec '!inkscape-figures edit \"'.b:vimtex.root.'/figures/\" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>",
  opts,
  "Create new figure."
)

-- Insert Mode
keymap("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", opts, "Correct spelling mistake.")
keymap("i", "<C-j>", "<NOP>", opts, "")
keymap("i", "<C-k>", "<NOP>", opts, "")
keymap(
  "i",
  "<C-f>",
  "<Esc>: silent exec '.!inkscape-figures create \"'.getline('.').'\" \"'.b:vimtex.root.'/figures/\"'<CR><CR>:w<CR>",
  opts,
  "List all figures."
)

-- Terminal Mode
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts, "Jump to left split.")
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts, "Jump to below split.")
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts, "Jump to above split.")
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts, "Jump to right split.")

-- Visual Mode
keymap("v", "<", "<gv", opts, "")
keymap("v", ">", ">gv", opts, "")
keymap("v", "J", ":m '>+1<CR>gv=gv", opts, "")
keymap("v", "K", ":m '<-2<CR>gv=gv", opts, "")
keymap("v", "K", ":move '<-2<CR>gv-gv", opts, "")
keymap("v", "J", ":move '>+1<CR>gv-gv", opts, "")

-- Visual Block Mode
keymap("x", "<A-j>", ":m '>+1<CR>gv-gv", opts, "")
keymap("x", "<A-k>", ":m '<-2<CR>gv-gv", opts, "")
