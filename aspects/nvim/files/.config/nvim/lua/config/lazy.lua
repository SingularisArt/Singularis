if vim.g.isInkscape then
  return
end

local argc = vim.fn.argc() or 0
if argc > 0 then
  local arg = vim.fn.argv()
  for i = 1, argc do
    if arg[i] == "--headless" then
      return
    end
  end
end
local loader = require("util.helper").loader
local fsize = vim.fn.getfsize(vim.fn.expand("%:p:f"))
if fsize == nil or fsize < 0 then
  fsize = 1
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
  vim.cmd([[packadd nvim-treesitter]])
  require("nvim-treesitter.configs").setup({
    highlight = { enable = true, use_languagetree = false },
  })
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

  -- local load_go = vim.tbl_contains({ "go", "gomod" }, vim.bo.filetype)
  -- if load_go and (not vim.g.isLATEX or not vim.g.isInkscape) then
  --   loader("go.nvim")
  -- end

  vim.g.vimsyn_embed = "lPr"

  if not vim.g.isLATEX or vim.g.isInkscape then
    loader("nvim-treesitter")
    -- loader("nvim-treesitter-textobjects")
    -- loader("nvim-treesitter-textsubjects")
    -- loader("nvim-ts-context-commentstring")
    loader("nvim-treesitter-context")

    loader("guihua.lua")
    -- loader("nvim-lspconfig")

    loader("navigator.lua")
    loader("fidget.nvim")
    loader("inlay-hints.nvim")
    loader("none-ls.nvim")
    loader("mason.nvim")
    loader("neogen")
    -- loader("indent-blankline.nvim")
  end

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

  loader("windline.nvim")
  -- require("modules.ui.eviline")

  local gitrepo = vim.fn.isdirectory(".git/index")
  if gitrepo then
    loader("gitsigns.nvim")
  end
end, lazy_timer + 10)
