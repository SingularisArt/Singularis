if vim.g.isLATEX or vim.g.isInkscape then
  return function(_use) end
end

local conf = require("modules.lsp.config")
-- local icons = require("config.global").icons

return function(use)
  ------------------------------
  --  General LSP Management  --
  ------------------------------

  -- lsp config
  use({
    "neovim/nvim-lspconfig",
    config = conf.nvim_lsp,
  })

  -- mason
  use({
    "williamboman/mason.nvim",
    after = "nvim-lspconfig",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "◍",
          package_pending = "◍",
          package_uninstalled = "◍",
        },
      },
      log_level = vim.log.levels.INFO,
      max_concurrent_installers = 4,
    },
  })

  -- formatter
  use({
    "nvimtools/none-ls.nvim",
    after = "nvim-lspconfig",
    config = conf.null_ls,
    dependencies = {
      {
        "jay-babu/mason-null-ls.nvim",
        after = "mason.nvim",
        config = conf.mason_null_ls,
      },
    },
  })

  -- lsp notifier
  use({
    "j-hui/fidget.nvim",
    branch = "legacy",
    opts = {
      sources = {
        ["null-ls"] = { ignore = true },
      },
    },
  })

  -- inlay hints
  use({
    "simrat39/inlay-hints.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("inlay-hints").setup()
    end,
  })

  -- lsp manager
  use({
    "ray-x/navigator.lua",
    after = "nvim-lspconfig",
    config = conf.navigator,
  })

  -- documentation
  use({
    "danymat/neogen",
    opts = {
      enabled = true,
      languages = {
        lua = {
          template = {
            annotation_convention = "ldoc",
          },
        },
        python = {
          template = {
            annotation_convention = "google_docstrings",
          },
        },
        rust = {
          template = {
            annotation_convention = "rustdoc",
          },
        },
        javascript = {
          template = {
            annotation_convention = "jsdoc",
          },
        },
        typescript = {
          template = {
            annotation_convention = "tsdoc",
          },
        },
        typescriptreact = {
          template = {
            annotation_convention = "tsdoc",
          },
        },
      },
    },
    cmd = "Neogen",
  })

  -- symbols outline
  use({
    "bassamsdata/namu.nvim",
    config = function()
      require("namu").setup({})
    end,
    cmd = "Namu",
  })

  -- -------------------------------------
  -- --  Language Specific LSP Plugins  --
  -- -------------------------------------

  -- -- typescript/javascript
  -- use({
  --   "dmmulroy/tsc.nvim",
  --   cmd = { "TSC" },
  --   config = true,
  -- })
  -- use({
  --   "pmizio/typescript-tools.nvim",
  --   ft = { "typescript", "typescriptreact" },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "neovim/nvim-lspconfig",
  --   },
  -- })
  -- use({
  --   "vuki656/package-info.nvim",
  --   event = "BufEnter package.json",
  --   config = conf.package_json,
  -- })
  -- use({
  --   "vuki656/package-info.nvim",
  --   event = "BufEnter package.json",
  --   opts = {
  --     colors = {
  --       up_to_date = "#3C4048",
  --       outdated = "#fc514e",
  --     },
  --     icons = {
  --       enable = true,
  --       style = {
  --         up_to_date = icons.ui.CheckSquare,
  --         outdated = icons.git.Remove,
  --       },
  --     },
  --     autostart = true,
  --     hide_up_to_date = true,
  --     hide_unstable_versions = true,
  --     package_manager = "npm",
  --   },
  -- })

  -- -- javascript react/typescript react
  -- use({ "ianks/vim-tsx", ft = "typescriptreact" })
  -- use({ "mxw/vim-jsx", ft = "javascriptreact" })

  -- -- rust
  -- use({ "simrat39/rust-tools.nvim", ft = "rust" })
  -- use({
  --   "Saecki/crates.nvim",
  --   config = function()
  --     require("crates").setup({
  --       null_ls = {
  --         enabled = true,
  --         name = "crates.nvim",
  --       },
  --     })
  --   end,
  --   ft = "toml",
  -- })

  -- -- java
  -- use({
  --   "mfussenegger/nvim-jdtls",
  --   ft = "java",
  -- })

  -- -- -- go
  -- -- use({
  -- --   "ray-x/go.nvim",
  -- --   dependencies = {
  -- --     "guihua.lua",
  -- --     "nvim-lspconfig",
  -- --     "nvim-treesitter",
  -- --   },
  -- --   config = conf.go,
  -- --   ft = { "go", "gomod" },
  -- --   build = ":lua require('go.install').update_all_sync()",
  -- -- })

  -- -- dart
  -- use({
  --   "akinsho/flutter-tools.nvim",
  --   config = conf.flutter_tools,
  --   ft = { "dart" },
  -- })

  -- -- cpp/c
  -- use({
  --   "p00f/clangd_extensions.nvim",
  --   config = conf.clangd_extensions,
  --   ft = { "cpp", "c" },
  -- })

  -- -- SQL/Databases
  -- use({
  --   "hbarral/vim-dadbod",
  --   cmd = {
  --     "DBUIToggle",
  --     "DBUI",
  --     "DBUIAddConnection",
  --     "DBUIFindBuffer",
  --     "DBUIRenameBuffer",
  --     "DBUILastQueryInfo",
  --   },
  --   dependencies = {
  --     "kristijanhusak/vim-dadbod-ui",
  --     "kristijanhusak/vim-dadbod-completion",
  --   },
  -- })
end
