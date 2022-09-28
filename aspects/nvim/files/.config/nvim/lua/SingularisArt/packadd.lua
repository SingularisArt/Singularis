local M = {}

M.load = function()
  local load = SingularisArt.plugin.load
  local lazy = SingularisArt.plugin.lazy

  local plugin_group = vim.api.nvim_create_augroup("PluginGroup", { clear = true })

  -- Speed up loading.
  load({
    plugin = "impatient.nvim",
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
      require("impatient")
    end,
  })
  load({
    plugin = "filetype.nvim",
    config = function()
      vim.g.did_load_filetypes = 1
    end,
  })

  -- Required stuff.
  load({
    plugin = "plenary.nvim",
  })
  load({
    plugin = "popup.nvim",
  })

  -- LSP.
  load({
    "nvim-lspconfig",
  })
  load({
    plugin = "mason.nvim",
  })
  load({
    plugin = "mason-lspconfig.nvim",
  })
  load({
    plugin = "mason-tool-installer.nvim",
  })
  load({
    plugin = "null-ls.nvim",
  })
  load({
    plugin = "SchemaStore.nvim",
  })
  load({
    plugin = "sqls.nvim",
  })
  load({
    plugin = "vim-illuminate",
  })
  load({
    plugin = "lsp-inlayhints.nvim",
  })
  load({
    plugin = "lsp_signature.nvim",
  })
  load({
    plugin = "symbols-outline.nvim",
  })

  -- Completion.
  load({
    plugin = "nvim-cmp",
    config = "cmp",
  })
  load({
    plugin = "cmp-buffer",
  })
  load({
    plugin = "cmp-calc",
  })
  load({
    plugin = "cmp-cmdline",
  })
  load({
    plugin = "cmp-emoji",
  })
  load({
    plugin = "cmp-nvim-ultisnips",
  })
  load({
    plugin = "cmp-path",
  })
  load({
    plugin = "cmp-nvim-lsp",
  })

  -- Debugger.
  lazy({
    plugin = "nvim-dap",
    config = "dap",
    event = "BufWinEnter",
    group = plugin_group,
  })
  lazy({
    plugin = "DAPInstall.nvim",
    event = "BufWinEnter",
    group = plugin_group,
  })
  lazy({
    plugin = "nvim-dap-ui",
    event = "BufWinEnter",
    group = plugin_group,
  })
  lazy({
    plugin = "nvim-dap-virtual-text",
    event = "BufWinEnter",
    group = plugin_group,
  })

  -- Tree sitter.
  load({
    plugin = "nvim-treesitter",
    config = "treesitter",
  })
  lazy({
    plugin = "nvim-ts-context-commentstring",
  })
  lazy({
    plugin = "playground",
  })

  -- Git.
  lazy({
    plugin = "gitsigns.nvim",
    config = "gitsigns",
    event = "BufRead",
    group = plugin_group,
  })
  lazy({
    plugin = "vim-fugitive",
  })
  lazy({
    plugin = "vim-rhubarb",
  })

  -- Color schemes.
  load({
    plugin = "base16-nvim",
  })
  load({
    plugin = "pinnacle",
  })

  -- Manage project
  load({
    plugin = "project.nvim",
    config = "project",
  })

  -- Telescope.
  load({
    plugin = "telescope.nvim",
    config = "telescope",
  })
  lazy({
    plugin = "telescope-ultisnips.nvim",
  })

  -- Snippets
  lazy({
    plugin = "ultisnips",
    config = "ultisnips",
  })

  -- Color viewer.
  lazy({
    plugin = "nvim-colorizer.lua",
    config = "colorizer",
  })

  -- File Browser.
  lazy({
    plugin = "vim-dirvish",
    config = "dirvish",
  })
  -- lazy({
  --   plugin = "nvim-tree.lua",
  --   config = "nvim-tree",
  -- })

  -- Show indentation.
  load({
    plugin = "indent-blankline.nvim",
    config = "indent-blankline",
  })

  -- Auto documentation.
  lazy({
    plugin = "neogen",
    config = "neogen",
  })

  -- Run code.
  lazy({
    plugin = "sniprun",
    config = "snip-run",
    event = "BufWinEnter",
    group = plugin_group,
  })

  -- Display mappings.
  lazy({
    plugin = "which-key.nvim",
    config = "which-key",
    event = "BufWinEnter",
  })

  -- Manage my wiki stuff.
  lazy({
    plugin = "corpus",
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
  lazy({
    plugin = "Comment.nvim",
    config = "comment",
    event = "BufWinEnter",
    group = plugin_group,
  })

  -- Auto pairs.
  lazy({
    plugin = "nvim-autopairs",
    config = "autopairs",
    event = "InsertEnter",
    group = plugin_group,
  })

  -- Comment highlighter.
  lazy({
    plugin = "todo-comments.nvim",
    config = "todo-comments",
  })

  -- View all changes within file.
  lazy({
    plugin = "undotree",
  })

  -- Distraction free coding.
  lazy({
    plugin = "zen-mode.nvim",
  })

  -- Highlight yanked text.
  lazy({
    plugin = "vim-highlightedyank",
  })

  -- Monitor what and how much I code.
  lazy({
    plugin = "vim-wakatime",
  })
end

return M
