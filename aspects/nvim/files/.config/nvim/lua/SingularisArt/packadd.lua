local M = {}

M.load = function()
  local load = SingularisArt.plugin.load
  local lazy = SingularisArt.plugin.lazy

  -- Speed up loading.
  load("impatient.nvim", {
    plugin_config = function()
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
    plugin_config = function()
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
  load("symbols-outline.nvim")
  -- load("fidget.nvim", {
  --   plugin_config = "fidget",
  -- })

  -- Completion.
  load("nvim-cmp", {
    plugin_config = "cmp",
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
    plugin_config = "dap",
  })
  lazy("DAPInstall.nvim")
  lazy("nvim-dap-ui")
  lazy("nvim-dap-virtual-text")

  -- Tree sitter.
  load("nvim-treesitter", {
    plugin_config = "treesitter",
  })
  lazy("nvim-ts-context-commentstring")

  -- Git.
  lazy("gitsigns.nvim", {
    plugin_config = "gitsigns",
  })

  -- Color schemes.
  load("base16-nvim")
  load("pinnacle")

  -- Manage project
  -- load("project.nvim", {
  --   plugin_config = "project",
  -- })
  -- lazy("nvim-spectre")

  -- Telescope.
  load("telescope.nvim", {
    plugin_config = "telescope",
    commands = {
      "Telescope",
    },
  })

  -- Snippets
  load("ultisnips", {
    plugin_config = "ultisnips",
  })

  -- Color viewer.
  -- lazy("nvim-colorizer.lua", {
  --   plugin_config = "colorizer",
  -- })

  -- Icon
  lazy("nvim-web-devicons", {
    commands = {
      "NvimTreeToggle",
    },
  })

  -- File Browser.
  lazy("nvim-tree.lua", {
    plugin_config = "nvim-tree",
    commands = {
      "NvimTreeToggle",
    },
  })

  -- Show indentation.
  lazy("indent-blankline.nvim", {
    plugin_config = "indent-blankline",
    -- event = "BufReadPre",
  })

  -- Auto documentation.
  lazy("neogen", {
    plugin_config = "neogen",
    commands = {
      "Neogen",
    },
  })

  -- Run code.
  -- lazy("sniprun", {
  --   plugin_config = "snip-run",
  -- })

  -- Display mappings.
  lazy("which-key.nvim", {
    plugin_config = "which-key",
  })

  -- Manage my wiki stuff.
  lazy("corpus", {
    plugin_config = function()
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
    plugin_config = "comment",
  })
  lazy("todo-comments.nvim", {
    plugin_config = "todo-comments",
  })

  -- Auto pairs.
  lazy("nvim-autopairs", {
    plugin_config = "autopairs",
  })

  -- View all changes within file.
  lazy("undotree", {
    plugin_config = "undotree",
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
    plugin_config = "cybu",
  })

  -- Session
  load("session-lens", {
    plugin_config = "session-manager",
  })
  load("auto-session", {
    plugin_config = "auto-session",
  })

  -- Quickfix
  lazy("nvim-bqf")

  -- Editing Support
  lazy("numb.nvim", {
    plugin_config = "numb",
  })
  lazy("zen-mode.nvim", {
    plugin_config = "zen-mode",
  })
  load("nvim-navic", {
    plugin_config = function()
      require("SingularisArt.config.navic")
      require("SingularisArt.config.winbar")
    end,
  })
  -- lazy("neoscroll.nvim", {
  --   plugin_config = "neoscroll",
  -- })

  -- Java
  lazy("nvim-jdtls")

  -- Rust
  -- load("rust-tools.nvim")
  -- load("crates.nvim", {
  --   config = "crates",
  -- })

  -- Markdown
  load("vim-markdown-toc")
  lazy("markdown-preview.nvim", {
    config = "markdown-preview",
    commands = {
      "MarkdownPreviewToggle",
    },
  })
  lazy("vim-table-mode", {
    commands = {
      "TableModeToggle",
    },
  })

  -- HTML
  lazy("MatchTagAlways")

  -- LaTeX
  load("vimtex", {
    config = "vimtex",
  })
  lazy("tex-conceal.vim", {
    pattern = "tex",
  })
end

return M
