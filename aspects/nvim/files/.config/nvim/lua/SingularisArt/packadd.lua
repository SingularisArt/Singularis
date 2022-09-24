local M = {}

M.load = function()
  local load = SingularisArt.plugin.load
  local lazy = SingularisArt.plugin.lazy

  -- Speed up loading.
  load("impatient.nvim", function()
    _G.__luacache_config = {
      chunks = {
        enable = true,
        path = vim.fn.stdpath("cache") .. "/luacache_chunks",
      },
      modpaths = {
        enable = true,
        path = vim.fn.stdpath("cache") .. "/luacache_modpaths",
      },
    }
    require("impatient")
  end)
  load("filetype.nvim", function()
    vim.g.did_load_filetypes = 1
  end)

  -- Required stuff.
  load("plenary.nvim")
  load("popup.nvim")

  -- LSP.
  load("nvim-lspconfig")
  load("mason.nvim")
  load("mason-lspconfig.nvim")
  load("mason-tool-installer.nvim")
  load("null-ls.nvim")
  load("SchemaStore.nvim")
  load("sqls.nvim")
  load("vim-illuminate")
  load("lsp-inlayhints.nvim")
  load("lsp_signature.nvim")
  load("symbols-outline.nvim")

  -- Completion.
  load("nvim-cmp", "cmp")
  load("cmp-buffer")
  load("cmp-calc")
  load("cmp-cmdline")
  load("cmp-emoji")
  load("cmp-nvim-ultisnips")
  load("cmp-path")
  load("cmp-nvim-lsp")

  -- Debugger.
  lazy("nvim-dap", "dap")
  lazy("DAPInstall.nvim")
  lazy("nvim-dap-ui")
  lazy("nvim-dap-virtual-text")

  -- Tree sitter.
  load("nvim-treesitter", "treesitter")
  lazy("nvim-ts-context-commentstring")
  lazy("playground")

  -- Git.
  lazy("gitsigns.nvim", "gitsigns")
  lazy("vim-fugitive")
  lazy("vim-rhubarb")

  -- Color schemes.
  load("base16-nvim")
  load("pinnacle")

  -- Telescope.
  load("telescope.nvim", "telescope")
  lazy("project.nvim", "project")

  -- Snippets
  lazy("ultisnips")

  -- Color viewer.
  lazy("nvim-colorizer.lua", "colorizer")

  -- File Browser.
  -- lazy("vim-dirvish", "dirvish")
  lazy("nvim-tree.lua", "nvim-tree")

  -- Show indentation.
  lazy("indent-blankline.nvim", "indent-blankline")

  -- Auto documentation.
  lazy("neogen")

  -- Run code.
  lazy("sniprun", "snip-run")

  -- Display mappings.
  lazy("which-key.nvim", "which-key")

  -- Manage my wiki stuff.
  lazy("corpus")

  -- Comment stuff out.
  lazy("Comment.nvim", "comment")

  -- Auto pairs.
  lazy("nvim-autopairs", "autopairs")

  -- Comment highlighter.
  lazy("todo-comments.nvim", "todo-comments")

  -- View all changes within file.
  lazy("undotree")

  -- Distraction free coding.
  lazy("zen-mode.nvim")

  -- Highlight yanked text.
  lazy("vim-highlightedyank")

  -- Monitor what and how much I code.
  lazy("vim-wakatime")
end

return M
