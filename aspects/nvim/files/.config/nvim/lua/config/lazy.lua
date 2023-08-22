local argc = vim.fn.argc() or 0
if argc > 0 then
  local arg = vim.fn.argv()
  for i = 1, argc do
    if arg[i] == "--headless" then
      return
    end
  end
  if vim.fn.isdirectory(arg[1]) == 1 then
    vim.cmd("Neotree")
  end
end
local loader = require("util.helper").loader
local fsize = vim.fn.getfsize(vim.fn.expand("%:p:f"))
if fsize == nil or fsize < 0 then
  fsize = 1
end

local load_ts_plugins = true
local load_lsp = true

if fsize > 1024 * 1024 then
  load_ts_plugins = false
  load_lsp = false
end

local createdir = function()
  local cache_dir = require("config.global").cache_dir
  local data_dir = {
    cache_dir .. "backup",
    cache_dir .. "sessions",
    cache_dir .. "swap",
    cache_dir .. "tags",
    cache_dir .. "undo",
  }
  if vim.fn.isdirectory(cache_dir) == 0 then
    os.execute("mkdir -p " .. cache_dir)
    for _, v in pairs(data_dir) do
      if vim.fn.isdirectory(v) == 0 then
        os.execute("mkdir -p " .. v)
      end
    end
  end
end

if vim.wo.diff then
  if load_ts_plugins then
    vim.cmd([[packadd nvim-treesitter]])
    require("nvim-treesitter.configs").setup({
      highlight = { enable = true, use_languagetree = false },
    })
  else
    vim.cmd([[syntax on]])
  end
  return
end

function Lazyload()
  require("config.helper").init()

  createdir()
  local disable_ft = {
    "NvimTree",
    "guihua",
    "neo-tree",
    "packer",
    "guihua_rust",
    "clap_input",
    "clap_spinner",
    "TelescopePrompt",
    "csv",
    "txt",
    "defx",
  }

  local syn_on = not vim.tbl_contains(disable_ft, vim.bo.filetype)
  if not syn_on then
    vim.cmd([[syntax manual]])
  end

  local load_go = vim.tbl_contains({ "go", "gomod" }, vim.bo.filetype)
  if load_go then
    loader("go.nvim")
  end

  if fsize > 2 * 1024 * 1024 then
    print("syntax off, enable it by :setlocal syntax=on")
    load_lsp = false
    load_ts_plugins = false
    vim.cmd([[syntax off]])
  end

  local plugins = "plenary.nvim"
  loader("plenary.nvim")

  if vim.bo.filetype == "lua" then
    loader("neodev.nvim")
  end

  vim.g.vimsyn_embed = "lPr"

  loader("guihua.lua")
  if load_lsp then
    loader("nvim-lspconfig")
    loader("lsp_signature.nvim")
  end

  if load_lsp or load_ts_plugins then
    loader("navigator.lua")
    loader("nvim-treesitter")
    loader("pretty_hover")
    loader("fidget.nvim")
    loader("inlay-hints.nvim")
    loader("null-ls.nvim")
    loader("mason.nvim")
    loader("lsp_lines.nvim")
    loader("lsp_lines.nvim")
  end

  if load_ts_plugins then
    plugins =
    "nvim-treesitter-textobjects nvim-treesitter-textsubjects nvim-treesitter-refactor nvim-ts-context-commentstring nvim-treesitter-context"
    loader(plugins)
    loader("neogen")
    loader("indent-blankline.nvim")
  end
  loader("null-ls.nvim")

  vim.cmd([[autocmd FileType vista,guihua,guihua_rust setlocal syntax=on]])
  vim.cmd(
    [[autocmd FileType * silent! lua if vim.fn.wordcount()["bytes"] > 2048000 then print("syntax off") vim.cmd("setlocal syntax=off") end]]
  )
end

local lazy_timer = 5

vim.defer_fn(function()
  Lazyload()
  vim.cmd([[doautocmd User LoadLazyPlugin]])
end, lazy_timer)

vim.defer_fn(function()
  loader("telescope.nvim")
  loader("harpoon")
  require("modules.ui.notify").setup()

  loader("windline.nvim")
  require("modules.ui.eviline")

  local gitrepo = vim.fn.isdirectory(".git/index")
  if gitrepo then
    loader("gitsigns.nvim")
    loader("git-conflict.nvim")
    loader("linediff.vim")
    loader("diffview.nvim")
    loader("neogit")
    loader("octo.nvim")
    loader("vim-gist")
  end

  loader("statuscol.nvim")
  -- if vim.fn.executable(vim.g.python3_host_prog) == 0 then
  --   print("file not find, please update path setup", vim.g.python3_host_prog)
  -- end
end, lazy_timer + 10)
