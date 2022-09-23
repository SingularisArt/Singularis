local M = {}

M.load = function()
  local packadd = SingularisArt.util.packadd
  local packadd_defer = SingularisArt.util.packadd_defer

  -- Required stuff.
  packadd("plenary.nvim")
  packadd("popup.nvim")

  -- Filetype configuration.
  packadd("filetype.nvim", "filetype")

  -- LSP.
  packadd("nvim-lspconfig")
  packadd("mason.nvim")
  packadd("mason-lspconfig.nvim")
  packadd("mason-tool-installer.nvim")
  packadd("null-ls.nvim")
  packadd("SchemaStore.nvim")
  packadd("sqls.nvim")
  packadd("vim-illuminate")
  packadd("lsp-inlayhints.nvim")
  packadd("lsp_signature.nvim")
  packadd("symbols-outline.nvim")

  -- Completion.
  packadd("nvim-cmp", "cmp")
  packadd("cmp-buffer")
  packadd("cmp-calc")
  packadd("cmp-cmdline")
  packadd("cmp-emoji")
  packadd("cmp-nvim-ultisnips")
  packadd("cmp-path")
  packadd("cmp-nvim-lsp")

  -- Debugger.
  packadd_defer("nvim-dap", "dap")
  packadd_defer("DAPInstall.nvim")
  packadd_defer("nvim-dap-ui")
  packadd_defer("nvim-dap-virtual-text")

  -- Tree sitter.
  packadd("nvim-treesitter", "treesitter")
  packadd_defer("nvim-ts-context-commentstring")
  packadd_defer("playground")

  -- Git.
  packadd_defer("gitsigns.nvim", "gitsigns")
  packadd_defer("vim-fugitive")
  packadd_defer("vim-rhubarb")

  -- Color schemes.
  packadd("base16-nvim")
  packadd("pinnacle")

  -- Telescope.
  packadd("telescope.nvim", "telescope")
  packadd_defer("project.nvim", "project")

  -- Snippets
  packadd_defer("ultisnips")

  -- Color viewer.
  packadd_defer("nvim-colorizer.lua", "colorizer")

  -- File Browser.
  packadd_defer("vim-dirvish", "dirvish")

  -- Show indentation.
  packadd_defer("indent-blankline.nvim", "indent-blankline")

  -- Auto documentation.
  packadd_defer("neogen")

  -- Run code.
  packadd_defer("sniprun", "snip-run")

  -- Display mappings.
  packadd_defer("which-key.nvim", "which-key")

  -- Manage my wiki stuff.
  packadd_defer("corpus")

  -- Comment stuff out.
  packadd_defer("Comment.nvim", "comment")

  -- Auto pairs.
  packadd_defer("nvim-autopairs", "autopairs")

  -- Comment highlighter.
  packadd_defer("todo-comments.nvim", "todo-comments")

  -- View all changes within file.
  packadd_defer("undotree")

  -- Distraction free coding.
  packadd_defer("zen-mode.nvim")

  -- Highlight yanked text.
  packadd_defer("vim-highlightedyank")

  -- Monitor what and how much I code.
  packadd_defer("vim-wakatime")
end

return M
