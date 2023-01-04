local lazy_timer = 20

local fsize = vim.fn.getfsize(vim.fn.expand("%:p:f"))
if fsize == nil or fsize < 0 then
  fsize = 1
end

local load_ts_plugins = true
local load_lsp_plugins = true

if fsize > 1024 * 1024 then
  load_ts_plugins = false
  load_lsp_plugins = false
end

local function Lazyload()
  local disable_ft = {
    "NvimTree",
    "guihua",
    "packer",
    "guihua_rust",
    "TelescopePrompt",
    "csv",
    "txt",
    "defx",
  }

  local syn_on = not vim.tbl_contains(disable_ft, vim.bo.filetype)
  if not syn_on then
    vim.cmd([[syntax manual]])
  end

  -- local fname = vim.fn.expand("%:p:f")
  if fsize > 6 * 1024 * 1024 then
    load_lsp_plugins = false
    load_ts_plugins = false
    vim.cmd([[syntax off]])
  end

  loader("telescope.nvim")
  loader("project.nvim")
  loader("auto-session")

  if vim.bo.filetype == "lua" then
    loader("neodev.nvim")
  end

  if load_lsp_plugins then
    loader("nvim-lspconfig")
    loader("mason.nvim")
    loader("sqls.nvim")
    loader("lspsaga.nvim")
    loader("SchemaStore.nvim")
    loader("fidget.nvim")
    loader("go.nvim")
    loader("lspsaga.nvim")
    loader("nvim-lightbulb")
    loader("lsp_signature.nvim")
  end

  if load_ts_plugins then
    loader("nvim-treesitter")
    loader("neogen")
    loader("indent-blankline.nvim")
    loader("hlargs.nvim")
    loader("nvim-ufo")
  else
    vim.cmd([[packadd nvim-treesitter]])
  end

  loader("guihua.lua")
  if load_lsp_plugins or load_ts_plugins then
    loader("navigator.lua")
  end

  -- loader("null-ls.nvim")

  -- loader("neotest")
  -- loader("nvim-dap")

  -- loader("which-key.nvim")
  -- loader("nvim-notify")
  -- loader("bufferline.nvim")

  -- loader("lir.nvim")

  -- loader("ssr.nvim")
  -- loader("zen-mode.nvim")
  -- loader("twilight.nvim")
  -- loader("neoscroll.nvim")
  -- loader("cybu.nvim")
  -- loader("syntax-tree-surfer")
  -- loader("viewdoc.nvim")
  -- loader("nvim-autopairs")
  -- loader("nvim-surround")
  -- loader("nvim-gomove")
  -- -- loader("nvim-hlslens")
  -- loader("vim-visual-multi")
  -- loader("hop-extensions")

  -- loader("todo-comments.nvim")
  -- loader("Comment.nvim")

  -- loader("tex-conceal.vim")
  -- loader("vimtex")

  -- loader("vim-markdown-toc")
  -- loader("vim-table-mode")
  -- loader("markdown-preview.nvim")

  -- loader("vim-log-highlighting")

  -- loader("magma-nvim")
  -- loader("swenv.nvim")

  -- loader("rust-tools.nvim")
  -- loader("crates.nvim")

  -- loader("nvim-jdtls")
  -- loader("go.nvim")

  -- loader("neodev.nvim")

  -- loader("sqlite.lua")

  -- loader("clangd_extensions.nvim")

  -- loader("MatchTagAlways")
  -- loader("bracey.vim")
  -- loader("emmet-vim")

  -- loader("neorg")
  -- loader("org-bullets.nvim")
  -- loader("headlines.nvim")

  -- loader("diffview.nvim")
  -- loader("linediff.vim")
  -- loader("vim-fugitive")
  -- loader("vim-rhubarb")
  -- loader("forgit.nvim")
  -- loader("neogit")
  -- loader("octo.nvim")
  -- loader("vim-gist")
  -- loader("git-conflict.nvim")
  -- loader("gitsigns.nvim")
  -- loader("git-worktree.nvim")
end

vim.defer_fn(function()
  Lazyload()
end, lazy_timer)
