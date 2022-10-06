local M = {}

M.load = function()
  local load = SingularisArt.plugin.load
  local lazy = SingularisArt.plugin.lazy

  -- Speed up loading.
  load("impatient.nvim", {
    config = function()
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
      local impatient = require("impatient")
      impatient.enable_profile()
    end,
  })
  load("filetype.nvim", {
    config = function()
      vim.g.did_load_filetypes = 1
    end,
  })

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
  lazy("symbols-outline.nvim", {
    config = "symbols-outline",
    commands = {
      "SymbolsOutlineToggle",
    },
  })
  lazy("fidget.nvim", {
    config = "fidget",
  })

  -- Completion.
  load("nvim-cmp", {
    config = "cmp",
  })
  load("cmp-buffer")
  load("cmp-calc")
  load("cmp-nvim-ultisnips")
  load("cmp-path")
  load("cmp-emoji")
  load("cmp-nvim-lsp")
  load("cmp-nvim-lua")
  load("cmp-latex-symbols")
  load("cmp-tmux")

  -- Debugger.
  lazy("nvim-dap", {
    config = "dap",
  })
  lazy("DAPInstall.nvim")
  lazy("nvim-dap-ui")
  lazy("nvim-dap-virtual-text")

  -- Tree sitter.
  load("nvim-treesitter", {
    config = "treesitter",
  })
  lazy("nvim-ts-context-commentstring")

  -- Git.
  lazy("gitsigns.nvim", {
    config = "gitsigns",
  })

  -- Color schemes.
  load("base16-nvim")
  load("tokyonight.nvim")
  load("pinnacle")

  -- Manage project
  lazy("project.nvim", {
    config = "project",
  })
  lazy("nvim-spectre")

  -- Telescope.
  lazy("telescope.nvim", {
    config = "telescope",
  })

  -- Snippets
  load("ultisnips", {
    config = "ultisnips",
  })

  -- Color viewer.
  -- lazy("nvim-colorizer.lua", {
  --   config = "colorizer",
  -- })

  -- Icon
  lazy("nvim-web-devicons", {
    commands = {
      "NvimTreeToggle",
    },
  })

  -- File Browser.
  lazy("nvim-tree.lua", {
    config = "nvim-tree",
    commands = {
      "NvimTreeToggle",
    },
  })

  -- Show indentation.
  load("indent-blankline.nvim", {
    config = "indent-blankline",
  })

  -- Auto documentation.
  lazy("neogen", {
    config = "neogen",
    commands = {
      "Neogen",
    },
  })

  -- Run code.
  -- lazy("sniprun", {
  --   config = "snip-run",
  --   commands = {
  --     "SnipRun",
  --   },
  -- })

  -- Display mappings.
  load("which-key.nvim", {
    config = "which-key",
  })

  -- Manage my wiki stuff.
  lazy("corpus", {
    config = function()
      CorpusDirectories = {
        ["~/Documents/Website/content/posts"] = {
          autocommit = true,
          autoreference = 0,
          autotitle = 0,
          base = "~/Documents/Website/",
          repo = "~/Documents/Website/",
          transform = "web",
        },
      }
    end,
  })

  -- Comment stuff out.
  lazy("Comment.nvim", {
    config = "comment",
  })
  lazy("todo-comments.nvim", {
    config = "todo-comments",
  })

  -- Auto pairs.
  lazy("nvim-autopairs", {
    config = "autopairs",
  })

  -- View all changes within file.
  lazy("undotree", {
    config = "undotree",
    commands = {
      "UndotreeToggle",
    },
  })

  -- Highlight yanked text.
  lazy("vim-highlightedyank")

  -- Monitor what and how much I code.
  lazy("vim-wakatime")

  -- Utility
  lazy("cybu.nvim", {
    config = "cybu",
  })

  -- Session
  -- load("session-lens", {
  --   config = "session-manager",
  -- })
  -- load("auto-session", {
  --   config = "auto-session",
  -- })

  -- Quickfix
  lazy("nvim-bqf")

  -- Editing Support
  lazy("numb.nvim", {
    config = "numb",
  })
  lazy("zen-mode.nvim", {
    config = "zen-mode",
  })
  load("nvim-navic", {
    config = function()
      require("SingularisArt.config.navic")
      require("SingularisArt.config.winbar")
    end,
  })
  -- lazy("neoscroll.nvim", {
  --   config = "neoscroll",
  -- })

  -- Java
  load("nvim-jdtls")

  -- Rust
  lazy("rust-tools.nvim", {
    config = "rust-tools",
  })
  lazy("crates.nvim", {
    -- config = "crates",
    config = function()
      require("crates").setup()
    end,
  })

  -- Markdown
  load("vim-markdown-toc")
  load("markdown-preview.nvim", {
    config = "markdown-preview",
  })
  lazy("vim-table-mode", {
    commands = {
      "TableModeToggle",
    },
  })

  -- Python
  lazy("magma-nvim", {
    config = "magma",
  })

  -- HTML
  lazy("MatchTagAlways", {
    pattern = "html",
  })

  -- LaTeX
  load("vimtex", {
    config = "vimtex",
  })
  lazy("tex-conceal.vim", {
    pattern = "tex",
  })
end

return M
