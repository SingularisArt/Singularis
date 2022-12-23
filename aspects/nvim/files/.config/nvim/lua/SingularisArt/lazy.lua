local lazy_timer = 20

local fsize = vim.fn.getfsize(vim.fn.expand("%:p:f"))
if fsize == nil or fsize < 0 then
  fsize = 1
end

local load_ts = true
local load_lsp = true

if fsize > 1024 * 1024 then
  load_ts = false
  load_lsp = false
end

local function loader(plugin)
  require("lazy").load({
    plugins = plugin,
  })
end

local function Lazyload()
  local plugins = {
    "plenary.nvim",
    "null-ls.nvim",
    "nvim-notify",
    "nvim-web-devicons",
    "lir.nvim",
    "nvim-dap",
    "telescope.nvim",
    "vim-fugitive",
    "vim-rhubarb",
    "forgit.nvim",
    "codewindow.nvim",
    "git-conflict.nvim",
    "gitsigns.nvim",
    "vimtex",
    "tex-conceal.vim",
    "vim-markdown-toc",
    "vim-table-mode",
    "markdown-preview.nvim",
    "magma-nvim",
    "swenv.nvim",
    "rust-tools.nvim",
    "crates.nvim",
    "nvim-jdtls",
    "MatchTagAlways",
    "bracey.vim",
    "emmet-vim",
    "go.nvim",
    "vim-log-highlighting",
    "neorg",
    "vim-matchup",
    "vim-bbye",
    "vim-slash",
    "nvim-surround",
    "tabout.nvim",
    "harpoon",
    "webapi-vim",
    "splitjoin.vim",
    "numb.nvim",
    "Comment.nvim",
    "todo-comments.nvim",
    "nvim-autopairs",
    "vim-highlightedyank",
    "vim-wakatime",
    "nvim-bqf",
    "indent-blankline.nvim",
    "dial.nvim",
    "hop.nvim",
    "neotest",
    "nvim-regexplainer",
    "nvim-surround",
    "nvim-ufo",
    "virt-column.nvim",
  }

  if load_lsp then
    local lsp_plugins = {
      "nvim-lspconfig",
      "lsp-inlayhints.nvim",
      "lsp_signature.nvim",
      "guihua.lua",
      "SchemaStore.nvim",
      "sqls.nvim",
      "lspsaga.nvim",
      "lsp_lines.nvim",
      "navigator.lua",
      "neoconf.nvim",
      "neodev.nvim",
      "fidget.nvim",
      "vim-illuminate",
      "clangd_extensions.nvim",
    }
    loader(lsp_plugins)
  end

  if load_ts then
    local ts_plugins = {
      "nvim-treesitter",
    }
    loader(ts_plugins)
  end

  -- if load_lsp and load_ts then end

  loader(plugins)
end

vim.defer_fn(function()
  Lazyload()
  vim.cmd([[doautocmd User LoadLazyPlugin]])
end, lazy_timer)
