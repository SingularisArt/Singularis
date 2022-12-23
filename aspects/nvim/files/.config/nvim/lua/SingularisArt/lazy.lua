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
    "diffview.nvim",
    "linediff.vim",
    "vim-fugitive",
    "vim-rhubarb",
    "forgit.nvim",
    "neogit",
    "vim-matchup",
    "vim-bbye",
    "vim-slash",
    "tabout.nvim",
    "harpoon",
    "webapi-vim",
    "splitjoin.vim",
    "vim-highlightedyank",
    "vim-wakatime",
    "nvim-spectre",
    "dial.nvim",
    "vim-startuptime",
    "fzy-lua-native",
    "fzy-lua-native",
    "spelunker.vim",
    "plenary.nvim",
    "nvim-lspconfig",
    "lsp-inlayhints.nvim",
    "lsp_signature.nvim",
    "guihua.lua",
    "SchemaStore.nvim",
    "sqls.nvim",
    "nvim-luadev",
    "diffview.nvim",
    "linediff.vim",
    "vim-fugitive",
    "vim-rhubarb",
    "forgit.nvim",
    "neogit",
    "vim-matchup",
    "vim-bbye",
    "vim-slash",
    "tabout.nvim",
    "harpoon",
    "webapi-vim",
    "splitjoin.vim",
    "vim-highlightedyank",
    "vim-wakatime",
    "nvim-spectre",
    "dial.nvim",
    "vim-startuptime",
    "fzy-lua-native",
    "fzy-lua-native",
    "spelunker.vim",
    "null-ls.nvim",
    "lspsaga.nvim",
    "lsp_lines.nvim",
    "sad.nvim",
    "navigator.lua",
    "neoconf.nvim",
    "neodev.nvim",
    "fidget.nvim",
    "symbols-outline.nvim",
    "trouble.nvim",
    "vim-illuminate",
    "nvim-notify",
    "corpus",
    "nvim-tree.lua",
    "neo-tree.nvim",
    "lir.nvim",
    "bufferline.nvim",
    "close-buffers.nvim",
    "neogen",
    "nvim-dap",
    "nvim-colorizer.lua",
    "telescope.nvim",
    "telescope-dap.nvim",
    "telescope-file-browser.nvim",
    "telescope-frecency.nvim",
    "telescope-live-grep-args.nvim",
    "neorg-telescope",
    "vgit.nvim",
    "octo.nvim",
    "vim-gist",
    "git-conflict.nvim",
    "gitsigns.nvim",
    "git-worktree.nvim",
    "vimtex",
    "tex-conceal.vim",
    "vim-markdown",
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
    "clangd_extensions.nvim",
    "neorg",
    "sqlite.lua",
    "ssr.nvim",
    "refactoring.nvim",
    "codewindow.nvim",
    "numb.nvim",
    "zen-mode.nvim",
    "twilight.nvim",
    "Comment.nvim",
    "todo-comments.nvim",
    "nvim-autopairs",
    "undotree",
    "nvim-bqf",
    "indent-blankline.nvim",
    "hop.nvim",
    "neotest",
    "nvim-regexplainer",
    "nvim-surround",
    "nvim-ufo",
    "virt-column.nvim",
    "hlargs.nvim",
    "nvim-neoclip.lua",
    "viewdoc.nvim",
  }

  if load_lsp then
    local lsp_plugins = {
      "nvim-lspconfig",
      "lsp-inlayhints.nvim",
      "lsp_signature.nvim",
      "guihua.lua",
      "SchemaStore.nvim",
      "sqls.nvim",
      "nvim-luadev",
    }
    loader(lsp_plugins)
  end

  if load_ts then
    local ts_plugins = {
      "nvim-treesitter",
      "playground",
      "nvim-treesitter-textobjects",
      "nvim-treesitter-textsubjects",
      "nvim-treesitter-refactor",
      "nvim-treesitter-context",
      "nvim-ts-rainbow",
      "nvim-ts-autotag",
    }
    loader(ts_plugins)
  end

  loader(plugins)
end

vim.defer_fn(function()
  Lazyload()
end, lazy_timer)
