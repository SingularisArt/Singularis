local M = {}

local opt = vim.opt
local g = vim.g

M.general = function()
  g.mapleader = " " -- Set the leader key
  g.maplocalleader = " " -- Set the local leader key
  g.netrw_banner = 0 -- Remove the banner above netrw
  g.markdown_recommended_style = 0 -- Fix markdown indentation settings

  opt.autowrite = true -- Enable auto write
  opt.clipboard = "unnamedplus" -- Sync with system clipboard
  opt.completeopt = "menu,menuone,noselect"
  opt.conceallevel = 2 -- Hide * markup for bold and italic
  opt.confirm = true -- Confirm to save changes before exiting modified buffer
  opt.cursorline = true -- Enable highlighting of the current line
  opt.expandtab = true -- Use spaces instead of tabs
  opt.formatoptions = "jcroqlnt" -- Tcqj
  opt.grepformat = "%f:%l:%c:%m" -- Format
  opt.grepprg = "rg --vimgrep" -- For searching
  opt.ignorecase = true -- Ignore case
  -- opt.inccommand = "nosplit" -- Preview incremental substitute
  opt.laststatus = 3 -- Make statusbar cover entire area
  opt.breakindent = true -- Break indentation for long lines
  opt.showbreak = "↳" -- Character for line break
  opt.list = true -- Show some invisible characters (tabs...
  opt.mouse = "a" -- Enable mouse mode
  opt.number = true -- Print line number
  opt.pumblend = 10 -- Popup blend
  opt.pumheight = 10 -- Maximum number of entries in a popup
  opt.relativenumber = true -- Relative line numbers
  opt.scrolloff = 4 -- Lines of context
  opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
  opt.shiftround = true -- Round indent
  opt.shiftwidth = 2 -- Size of an indent
  opt.shortmess:append({ W = true, I = true, c = true })
  opt.showmode = false -- Dont show mode since we have a statusline
  opt.sidescrolloff = 8 -- Columns of context
  opt.smartcase = true -- Don't ignore case with capitals
  opt.smartindent = true -- Insert indents automatically
  opt.spelllang = { "en" } -- Languages used for spell check
  opt.splitbelow = true -- Put new windows below current
  opt.splitright = true -- Put new windows right of current
  opt.tabstop = 2 -- Number of spaces tabs count for
  opt.termguicolors = true -- True color support
  opt.timeoutlen = 300 -- Timeout in milliseconds before which key pops up
  opt.undofile = true -- Keep undo files
  opt.undolevels = 10000 -- Level of undo times
  opt.updatetime = 200 -- Save swap file and trigger CursorHold
  opt.wildmode = "longest:full,full" -- Command-line completion mode
  opt.wildignore:append({".javac", "node_modules", "*.pyc"})
  opt.wildignore:append({".aux", ".out", ".toc"}) -- LaTeX
  opt.wildignore:append({
    ".o", ".obj", ".dll", ".exe", ".so", ".a", ".lib", ".pyc", ".pyo", ".pyd",
    ".swp", ".swo", ".class", ".DS_Store", ".git", ".hg", ".orig"
  })
  opt.winminwidth = 5 -- Minimum window width
  opt.wrap = false -- Disable line wrap
  opt.inccommand = "split" -- "for incsearch while sub
  -- Folds
  -- opt.foldmethod = "expr" -- treesiter time
  -- opt.foldexpr = "nvim_treesitter#foldexpr()" -- treesiter
  -- opt.foldtext = ""

  opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time

  if vim.fn.has("nvim-0.9.0") == 1 then
    opt.splitkeep = "screen"
    opt.shortmess:append({ C = true })
  end

  vim.cmd("set rtp+=~/Documents/school-notes/current-course")
end

-- Function for setting tex options
M.tex = function()
  opt.spell = true
  opt.tw = 80
  opt.fillchars = { fold = " ", vert = "│" }
  opt.foldlevel = 99
  opt.foldmethod = "manual"
end

return M
