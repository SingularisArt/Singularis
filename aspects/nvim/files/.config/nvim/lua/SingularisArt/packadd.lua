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

  -- Notifications.
  lazy("nvim-notify", {
    config = "notify",
  })

  -- LSP.
  load("nvim-lspconfig")
  load("mason.nvim")
  load("mason-lspconfig.nvim")
  load("mason-tool-installer.nvim")
  load("null-ls.nvim")
  load("SchemaStore.nvim")
  load("sqls.nvim")
  load("vim-illuminate", {
    config = "illuminate",
  })
  load("lsp-inlayhints.nvim")
  load("lsp_signature.nvim")
  load("guihua.lua")
  load("navigator.lua")
  lazy("symbols-outline.nvim", {
    config = "symbols-outline",
    commands = {
      "SymbolsOutlineToggle",
    },
  })
  -- lazy("fidget.nvim", {
  --   config = "fidget",
  -- })

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
  load("nvim-cmp-buffer-lines")
  load("cmp-latex-symbols", {
    event = "FileType",
    pattern = "tex",
  })
  -- load("cmp-tmux")

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
  lazy("nvim-surround")

  -- Git.
  lazy("gitsigns.nvim", {
    config = "gitsigns",
  })

  -- Color schemes.
  load("tokyonight.nvim")
  load("base16-nvim")
  load("catppuccin")
  load("onedarker.nvim")
  load("darkplus.nvim")
  load("colorschemes")
  load("synthwave84.nvim")
  load("pinnacle")

  -- Noice Animations.
  load("nui.nvim")
  load("noice.nvim", {
    -- config = function()
    --   require("noice").setup()
    -- end
  })

  -- Colors
  lazy("colortils.nvim")

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
  lazy("nvim-colorizer.lua", {
    config = "colorizer",
  })

  -- Icon
  lazy("nvim-web-devicons")

  -- File Browser.
  lazy("nvim-tree.lua", {
    config = "nvim-tree",
    commands = {
      "NvimTreeToggle",
    },
  })
  lazy("lir.nvim", {
    config = "lir",
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
  -- lazy("vim-doge")

  -- Run code.
  lazy("sniprun", {
    config = "snip-run",
    commands = {
      "SnipRun",
    },
  })

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

  -- Utility.
  lazy("cybu.nvim", {
    config = "cybu",
  })

  -- Session.
  lazy("session-lens", {
    config = "session-manager",
  })
  lazy("auto-session", {
    config = "auto-session",
  })

  -- Quickfix.
  lazy("nvim-bqf", {
    config = "bqf",
  })

  -- Editing Support.
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
  lazy("neoscroll.nvim", {
    config = "neoscroll",
  })

  -- LaTeX.
  -- Can't lazy load this one for some reason.
  load("vimtex", {
    config = "vimtex",
  })

  -- Markdown.
  -- Can't lazy load these ones for some reason.
  load("markdown-preview.nvim", {
    config = "markdown-preview",
  })
  load("vim-markdown-toc")

  -- It's a duck motherducker!
  load("duck.nvim", {
    config = function()
      vim.keymap.set("n", "<leader>Dd", function()
        require("duck").hatch()
      end, {})
      vim.keymap.set("n", "<leader>Dk", function()
        require("duck").cook()
      end, {})
    end
  })
end

return M
