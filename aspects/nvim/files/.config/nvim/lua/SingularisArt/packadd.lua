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

  -----------------------
  --  Mandatory Stuff  --
  -----------------------

  load("plenary.nvim")
  load("popup.nvim")

  -----------
  --  LSP  --
  -----------

  load("nvim-lspconfig")
  load("mason.nvim")
  load("mason-lspconfig.nvim")
  load("mason-null-ls.nvim")
  load("mason-tool-installer.nvim")
  load("null-ls.nvim")
  load("lsp-inlayhints.nvim")
  load("lsp_signature.nvim")
  load("guihua.lua")
  load("navigator.lua")
  load("vim-illuminate", {
    config = "illuminate",
  })
  lazy("symbols-outline.nvim", {
    config = "symbols-outline",
    commands = {
      "SymbolsOutlineToggle",
    },
  })
  -- load("SchemaStore.nvim")
  -- load("sqls.nvim")
  -- load("lsp-zero.nvim")
  -- lazy("fidget.nvim", {
  --   config = "fidget",
  -- })

  -------------------------
  --  Completion Engine  --
  -------------------------

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
  -- load("nvim-cmp-buffer-lines")
  -- load("cmp-tmux")
  -- load("cmp-cmdline")
  -- load("cmp-git")
  -- load("cmp-latex-symbols", {
  --   event = "FileType",
  --   pattern = "tex",
  -- })

  ----------------
  --  Debugger  --
  ----------------

  lazy("nvim-dap", {
    config = "dap",
  })
  lazy("DAPInstall.nvim")
  lazy("nvim-dap-ui")
  lazy("nvim-dap-virtual-text")
  -- lazy("nvim-dap-python")

  ---------------------------
  --  Syntax Highlighting  --
  ---------------------------

  load("nvim-treesitter", {
    config = "treesitter",
  })
  load("nvim-ts-context-commentstring")
  load("playground")
  -- load("nvim-tree-docs")

  -----------------------
  --  Git Integration  --
  -----------------------

  lazy("gitsigns.nvim", {
    config = "gitsigns",
  })
  lazy("vim-fugitive")
  lazy("vim-rhubarb")
  lazy("gitlinker.nvim")
  lazy("octo.nvim")
  lazy("vim-gist")
  -- lazy("git-blame.nvim")

  --------------------
  --  Colorschemes  --
  --------------------

  load("tokyonight.nvim")
  load("base16-nvim")
  load("catppuccin")
  load("onedarker.nvim")
  load("darkplus.nvim")
  load("colorschemes")
  load("synthwave84.nvim")
  load("pinnacle")
  lazy("colortils.nvim")
  lazy("nvim-colorizer.lua", {
    config = "colorizer",
  })

  ------------------
  --  Animations  --
  ------------------

  load("nui.nvim")
  load("noice.nvim", {
    config = function()
      require("noice").setup()
    end,
  })

  -----------------
  --  Telescope  --
  -----------------

  -- Core Plugins
  lazy("telescope.nvim", {
    config = "telescope",
  })
  -- Extensions
  lazy("telescope-media-files.nvim")
  lazy("project.nvim", {
    config = "project",
  })
  -- lazy("neorg-telescope")
  -- lazy("telescope-ultisnips.nvim")
  -- lazy("browse.nvim")

  ----------------
  --  Snippets  --
  ----------------

  load("ultisnips", {
    config = "ultisnips",
  })

  ---------------------
  --  File Browsing  --
  ---------------------

  -- Nice icons.
  lazy("nvim-web-devicons")
  -- Side file Browser.
  lazy("nvim-tree.lua", {
    config = "nvim-tree",
    commands = {
      "NvimTreeToggle",
    },
  })
  -- Floating file browser.
  lazy("lir.nvim", {
    config = "lir",
  })
  -- Inline file browser.
  -- lazy("vim-dirvish", {
  --   config = "dirvish",
  -- })

  ---------------------
  --  Documentation  --
  ---------------------

  lazy("neogen", {
    config = "neogen",
    commands = {
      "Neogen",
    },
  })
  -- lazy("vim-doge")

  ----------------
  --  Run Code  --
  ----------------

  lazy("sniprun", {
    config = "snip-run",
    commands = {
      "SnipRun",
    },
  })

  ----------------
  --  Mappings  --
  ----------------

  load("which-key.nvim", {
    config = "which-key",
  })

  -------------
  --  Notes  --
  -------------

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

  -----------------
  --  Utilities  --
  -----------------

  -- Jump between buffers with ease.
  lazy("cybu.nvim", {
    config = "cybu",
  })
  -- Creates nice UI.
  lazy("dressing.nvim")
  -- Session managers.
  load("session-lens", {
    config = "session-manager",
  })
  load("auto-session", {
    config = "auto-session",
  })

  -----------------------
  --  Editing Support  --
  -----------------------

  -- View line when typing something like `:50`.
  lazy("numb.nvim", {
    config = "numb",
  })
  -- Distraction free writing.
  lazy("zen-mode.nvim", {
    config = "zen-mode",
  })
  -- Top bar information display.
  load("nvim-navic", {
    config = function()
      require("SingularisArt.config.navic")
      require("SingularisArt.config.winbar")
    end,
  })
  -- Nice smooth scrolling.
  lazy("neoscroll.nvim", {
    config = "neoscroll",
  })

  -------------
  --  Other  --
  -------------

  -- Notifications.
  lazy("nvim-notify", {
    config = "notify",
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
  -- Quickfix.
  lazy("nvim-bqf", {
    config = "bqf",
  })
  -- Search and replace.
  lazy("nvim-spectre")
  -- Show indentation.
  load("indent-blankline.nvim", {
    config = "indent-blankline",
  })
  -- Run the code of any language.
  lazy("jaq-nvim")
  -- lazy("registers.nvim")
  -- lazy("vim-startuptime")
  -- lazy("nvim-surround")
  -- lazy("tabout.nvim")
  -- lazy("harpoon")
  -- lazy("zk-nvim")
  -- lazy("vim-bookmarks")
  -- lazy("toggleterm.nvim")
  -- lazy("webapi-vim")
  -- lazy("dial.nvim")
  -- lazy("hop.nvim")
  -- lazy("duck.nvim")
  -- load("vim-matchup")
  -- load("vim-bbye")
  -- load("vim-slash")
  -- load("neomake")

  -------------------------
  --  Language Specific  --
  -------------------------

  -- LaTeX.
  load("vimtex", {
    config = "vimtex",
  })
  load("tex-conceal.vim")

  -- Markdown.
  load("markdown-preview.nvim", {
    config = "markdown-preview",
  })
  load("vim-markdown-toc")
  lazy("vim-table-mode", {
    commands = {
      "TableModeToggle",
    },
  })

  -- Python
  load("magma-nvim")
  -- load("swenv.nvim")

  -- Rust
  lazy("rust-tools.nvim", {
    config = "rust-tools",
  })
  load("crates.nvim", {
    config = "crates",
  })

  -- JavaScript/Typescript
  load("typescript.nvim")

  -- Java
  load("nvim-jdtls")

  -- HTML
  -- load("MatchTagAlways")

  -- Neorg
  -- load("neorg")
end

return M
