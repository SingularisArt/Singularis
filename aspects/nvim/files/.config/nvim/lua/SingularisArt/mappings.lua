local mappings = {}

mappings.load = function()
  local keymap = vim.api.nvim_set_keymap

  local opts = { noremap = true, silent = true }
  local term_opts = { silent = true }

  -- Modes
  --   normal_mode = "n",
  --   insert_mode = "i",
  --   visual_mode = "v",
  --   visual_block_mode = "x",
  --   term_mode = "t",
  --   command_mode = "c",

  keymap("n", "<Space>", "", opts)

  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  -- Normal --
  keymap("n", "<C-h>", "<C-w>h", opts)
  keymap("n", "<C-j>", "<C-w>j", opts)
  keymap("n", "<C-k>", "<C-w>k", opts)
  keymap("n", "<C-l>", "<C-w>l", opts)
  keymap("n", "<Leader><Leader>", "<C-^>", opts)
  keymap("n", "n", "nzzzv", opts)
  keymap("n", "N", "Nzzzv", opts)
  keymap("n", "J", "mzJ`z", opts)
  keymap("n", "<C-Up>", ":resize -2<CR>", opts)
  keymap("n", "<C-Down>", ":resize +2<CR>", opts)
  keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
  keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
  keymap("n", "<Up>", ":cprev<CR>zzzv", opts)
  keymap("n", "<Right>", ":copen<CR>", opts)
  keymap("n", "<Down>", ":cnext<CR>zzzv", opts)
  keymap("n", "<Left>", ":cclose<CR>", opts)
  keymap("n", "<Leader>j", ":m . +1<CR>==", opts)
  keymap("n", "<Leader>k", ":m . -2<CR>==", opts)
  keymap("n", "<Leader>v", ":vsplit<CR>", opts)
  keymap("n", "<Leader>h", ":split<CR>", opts)
  keymap("n", "<C-w>", ":bdelete<CR>", opts)
  keymap("n", "<C-t>", ":tabnew<CR>", opts)
  keymap("n", "<C-a>", "ggVG", opts)
  keymap("n", ";", ":nohl<CR>", opts)

  -- Terminal Mode
  keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
  keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
  keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
  keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

  -- Visual Mode
  keymap("v", "<", "<gv", opts)
  keymap("v", ">", ">gv", opts)
  keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
  keymap("v", "K", ":m '<-2<CR>gv=gv", opts)
  keymap("v", "K", ":move '<-2<CR>gv-gv", opts)
  keymap("v", "J", ":move '>+1<CR>gv-gv", opts)

  -- Visual Block Mode
  keymap("x", "<A-j>", ":m '>+1<CR>gv-gv", opts)
  keymap("x", "<A-k>", ":m '<-2<CR>gv-gv", opts)
end

return mappings
