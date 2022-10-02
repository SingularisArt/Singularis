local M = {}

M.load = function()
  local home = vim.env.HOME
  local config = home .. "/.config/nvim"
  local root = vim.env.USER == "root"

  local setlocal = SingularisArt.vim.setlocal
  local join = SingularisArt.util.join
  local range = SingularisArt.util.range

  ------------------------------------------------------------------------
  --                              General                               --
  ------------------------------------------------------------------------

  vim.opt.hidden = true -- Allow switching from unsaved buffer.
  vim.opt.emoji = false -- Don't assume all emoji are double width.
  vim.opt.formatoptions:append("j") -- Remove comment leader when joining comment lines.
  vim.opt.formatoptions:append("n") -- Smart auto-indenting inside numbered lists.
  vim.opt.belloff = "all" -- Never ring the bell for any reason.
  vim.opt.wrap = false -- Display long lines as just one line.
  vim.opt.encoding = "utf-8" -- Display this encoding.
  vim.opt.fileencoding = "utf-8" -- Use this encoding when writing to file.
  vim.opt.mouse = "a" -- Enable mouse.
  vim.opt.backup = false -- Don't store backup.
  vim.opt.writebackup = false -- Don't store backup.
  vim.opt.timeoutlen = 200 -- Faster response at cost of fast typing.
  vim.opt.updatetime = 300 -- Faster CursorHold.
  vim.opt.switchbuf = "usetab" -- Use already opened buffers when switching.
  vim.opt.modeline = true -- Allow modeline.
  vim.opt.lazyredraw = true -- Use lazy redraw.
  vim.opt.scrolloff = 3 -- Start scrolling 3 lines before edge of viewport.
  vim.opt.sidescrolloff = 3 -- Same as scrolloff, but for columns.
  vim.opt.winblend = 10 -- Psuedo-transparency for floating windows.
  vim.opt.updatecount = 0 -- Update swapfiles every 80 typed chars.
  vim.opt.viewoptions = "cursor,folds" -- Save/restore just these (with `:{mk,load}view`).
  vim.opt.visualbell = true -- Stop annoying beeping for non-error errors.
  vim.opt.whichwrap = "b,h,l,s,<,>,[,],~" -- Allow <BS>/h/l/<Left>/<Right>/<Space>, ~ to cross line boundaries.
  vim.opt.wildcharm = 26 -- ('<C-z>') substitute for 'wildchar' (<Tab>) in macros.
  vim.opt.wildignore:append("*.o,*.rej,*.so") -- Patterns to ignore during file-navigation.
  vim.opt.wildmenu = true -- Show options as list when switching buffers etc.
  vim.opt.wildmode = "longest:full,full" -- Shell-like autocomplete to unambiguous portion.
  vim.opt.backspace = "indent,start,eol" -- Allow unrestricted backspacing in insert mode.
  vim.opt.backupskip = vim.opt.backupskip + "*.re,*.rei" -- Prevent bsb's watch mode from getting confused (if 'backup' is ever set).
  vim.opt.diffopt:append("foldcolumn:0") -- Don't show fold column in diff view.
  vim.opt.ignorecase = true -- Ignore case in searches.
  vim.opt.joinspaces = false -- Don't autoinsert two spaces after '.', '?', '!' for join command.
  vim.opt.undofile = true -- Enable persistent undo.
  vim.opt.directory = config .. "/misc/swap" -- Keep swap files out of the way: ~/.config/nvim/misc/swap/.
  vim.opt.viewdir = config .. "/misc/view" -- Where to store files for :mkview: ~/.config/nvim/misc/view/.
  vim.opt.backupcopy = "yes" -- Overwrite files to update, instead of renaming + rewriting.
  vim.opt.backupdir = config .. "/misc/backup" -- Keep backup files out of the way (ie. if 'backup' is ever set): ~/.config/nvim/misc/backup/.
  vim.opt.undodir = config .. "/misc/undo" -- keep undo files out of the way: ~/.config/nvim/misc/undo/.

  ------------------------------------------------------------------------
  --                                 UI                                 --
  ------------------------------------------------------------------------

  vim.opt.termguicolors = true -- Enable gui colors.
  vim.opt.laststatus = 3 -- Always show statusline.
  vim.opt.showtabline = 0 -- Don't show tabline.
  vim.opt.cursorline = true -- Enable highlighting of the current line.
  vim.opt.number = true -- Show line numbers.
  vim.opt.relativenumber = true -- Show relative numbers.
  vim.opt.splitbelow = true -- Horizontal splits will be below.
  vim.opt.splitright = true -- Vertical splits will be to the right.
  vim.opt.conceallevel = 2 -- Hide (conceal) special symbols (like `` in markdown).
  vim.opt.incsearch = true -- Show search results while typing.
  vim.opt.shortmess:append("A") -- Ignore annoying swapfile messages.
  vim.opt.shortmess:append("I") -- No splash screen.
  vim.opt.shortmess:append("O") -- File-read message overwrites previous.
  vim.opt.shortmess:append("T") -- Truncate non-file messages in middle.
  vim.opt.shortmess:append("W") -- Don't echo "[w]"/"[written]" when writing.
  vim.opt.shortmess:append("a") -- Use abbreviations in messages eg. `[RO]` instead of `[readonly]`.
  vim.opt.shortmess:append("c") -- Completion messages.
  vim.opt.shortmess:append("o") -- Overwrite file-written messages.
  vim.opt.shortmess:append("t") -- Truncate file messages at start.
  vim.opt.inccommand = "split" -- Live preview of :s results.
  vim.opt.showmode = true -- Show mode in command line.
  vim.opt.fillchars = {
    diff = "∙", -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99).
    eob = " ", -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer.
    fold = "·", -- MIDDLE DOT (U+00B7, UTF-8: C2 B7).
    vert = "┃", -- BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83).
  }
  vim.opt.list = true -- Show whitespace.
  vim.opt.listchars = {
    nbsp = "⦸", -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8).
    extends = "»", -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB).
    precedes = "«", -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB).
    tab = "▷⋯", -- WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + MIDLINE HORIZONTAL ELLIPSIS (U+22EF, UTF-8: E2 8B AF).
    trail = "•", -- BULLET (U+2022, UTF-8: E2 80 A2).
  }
  setlocal("colorcolumn", "+" .. join(range(80, 255), ",")) -- Add a colorcolumn.

  ------------------------------------------------------------------------
  --                              Editing                               --
  ------------------------------------------------------------------------

  vim.opt.expandtab = true -- Convert tabs to spaces.
  vim.opt.tabstop = 2 -- Insert 2 spaces for a tab.
  vim.opt.smarttab = true -- Make tabbing smarter (will realize you have 2 vs 4).
  vim.opt.shiftwidth = 2 -- Use this number of spaces for indentation.
  vim.opt.smartindent = true -- Make indenting smart.
  vim.opt.autoindent = true -- Use auto indent.
  vim.opt.iskeyword:append("-") -- Treat dash separated words as a word text object.
  vim.opt.virtualedit = "block" -- Allow going past the end of line in visual block mode.
  vim.opt.startofline = false -- Don't position cursor on line start after certain operations.
  vim.opt.breakindent = true -- Indent wrapped lines to match line start.
  vim.opt.smartcase = true -- Don't ignore case in searches if uppercase characters present.
  vim.opt.clipboard = "unnamedplus" -- Use system clipboard.

  vim.opt.suffixes:remove(".h") -- Don't sort header files at lower priority.
  vim.opt.swapfile = false -- Don't create swap files.
  vim.opt.synmaxcol = 200 -- Don't bother syntax highlighting long lines.
  vim.opt.textwidth = 80 -- Automatically hard wrap at 80 columns.

  vim.opt.completeopt = "menu" -- Show completion menu (for nvim-cmp).
  vim.opt.completeopt:append("menuone") -- Show menu even if there is only one candidate (for nvim-cmp).
  vim.opt.completeopt:append("noselect") -- Don't automatically select canditate (for nvim-cmp).

  vim.opt.shell = "sh" -- Shell to use for `!`, `:!`, `system()` etc.
  vim.opt.shiftround = false -- Don't always indent by multiple of shiftwidth.
  vim.opt.showbreak = "↳ " -- DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3).
  vim.opt.showcmd = false -- Don't show extra info at end of command line.
  vim.opt.sidescroll = 0 -- Sidescroll in jumps because terminals are slow.

  if root then
    vim.opt.shada = "" -- Don't create root-owned files.
    vim.opt.shadafile = "NONE"
  else
    -- Defaults:
    --   Neovim: !,'100,<50,s10,h

    -- - ! save/restore global variables (only all-uppercase variables).
    -- - '100 save/restore marks from last 100 files.
    -- - <50 save/restore 50 lines from each register.
    -- - s10 max item size 10KB.
    -- - h do not save/restore 'hlsearch' setting.

    -- Our overrides:
    -- - '0 store marks for 0 files.
    -- - <0 don't save registers.
    -- - f0 don't store file marks.
    -- - n: store in ~/.config/nvim/misc/shada.
    --
    vim.opt.shada = "'0,<0,f0,n~/.config/nvim/misc/shada"
  end

  vim.opt.modelines = 5 -- Scan this many lines looking for modeline.
  vim.opt.pumblend = 10 -- Pseudo-transparency for popup-menu.

  ------------------------------------------------------------------------
  --                              Spelling                              --
  ------------------------------------------------------------------------

  -- vim.opt.spelllang = "en,ar" -- Define spelling dictionaries.
  vim.opt.complete:append("kspell") -- Add spellcheck options for autocomplete.
  vim.opt.complete:remove("t") -- Don't use tags for completion.
  vim.opt.spelloptions = "camel" -- Treat parts of camelCase words as seprate words.

  -- Define pattern for a start of 'numbered' list. This is responsible for
  -- correct formatting of lists when using `gq`. This basically reads as 'at
  -- least one special character (digit, -, +, *) possibly followed some
  -- punctuation (. or `)`) followed by at least one space is a start of list
  -- item'.
  vim.opt.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

  ------------------------------------------------------------------------
  --                               Folds                                --
  ------------------------------------------------------------------------

  vim.opt.foldlevelstart = 99 -- Start unfolded.
  vim.opt.foldmethod = "expr" -- Not as cool as syntax, but faster.
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- Use TreeSitter for folding.
  vim.opt.foldtext = "v:lua.SingularisArt.foldtext()" -- Folding style (lua/SingularisArt/foldtext.lua).

  ------------------------------------------------------------------------
  --                           Miscellaneous                            --
  ------------------------------------------------------------------------

  vim.opt.rtp:append("~/Documents/school-notes/current-course")
  vim.cmd("filetype plugin indent on")
end

return M
