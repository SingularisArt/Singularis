if vim.g.isInkscape then
  return function(_use) end
end

local conf = require("modules.lsp.config")
local icons = require("config.global").icons

return function(use)
  use({
    "neovim/nvim-lspconfig",
    config = conf.nvim_lsp,
    dependencies = {
      "pmizio/typescript-tools.nvim",
      "simrat39/rust-tools.nvim",
      "clangd_extensions.nvim",
      { "folke/neoconf.nvim", cmd = "Neoconf" },
      {
        "folke/neodev.nvim",
        config = function()
          require("neodev").setup()
        end,
        ft = "lua",
      },
      {
        "williamboman/mason-lspconfig.nvim",
        after = "mason.nvim",
        config = function()
          require("mason-lspconfig").setup()
        end,
      },
    },
  })

  use({ "SmiteshP/nvim-navic" })

  use({
    "j-hui/fidget.nvim",
    branch = "legacy",
    opts = {
      sources = {
        ["null-ls"] = { ignore = true },
      },
    },
  })

  use({
    "simrat39/inlay-hints.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("inlay-hints").setup()
    end,
  })

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
    }
  })

  use({
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
      require("lsp_lines").toggle()
    end,
  })

  use({
    -- "ray-x/navigator.lua",
    "SingularisArt/navigator.lua",
    after = "nvim-lspconfig",
    config = conf.navigator,
  })

  use({
    "ray-x/lsp_signature.nvim",
    opts = {
      bind = true,
      noice = true,
      doc_lines = 10,

      max_height = 10,
      max_width = 80,

      wrap = true,
      fix_pos = false,

      floating_window = true,
      floating_window_above_cur_line = true,
      floating_window_off_x = 1,
      floating_window_off_y = 0,

      hint_enable = true,
      hi_parameter = "LspSignatureActiveParameter",

      toggle_key = "<C-s>",
      toggle_key_flip_floatwin_setting = true,

      hint_prefix = icons.misc.Squirrel .. " ",
      hint_scheme = "Comment",

      handler_opts = {
        border = "rounded",
      },
    }
  })

  use({
    "dnlhc/glance.nvim",
    config = conf.glance,
    cmd = { "Glance" },
  })

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

  use({ "b0o/SchemaStore.nvim", ft = { "json", "yaml" } })

  use({ "simrat39/rust-tools.nvim", ft = "rust" })
  use({
    "Saecki/crates.nvim",
    config = function()
      require("crates").setup({
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
      })
    end,
    ft = "toml",
  })

  use({
    "mfussenegger/nvim-jdtls",
    ft = "java",
  })

  use({
    "ray-x/go.nvim",
    dependencies = {
      "guihua.lua",
      "nvim-lspconfig",
      "nvim-treesitter",
    },
    config = conf.go,
    ft = { "go", "gomod" },
    build = ":lua require('go.install').update_all_sync()",
  })

  use({
    "akinsho/flutter-tools.nvim",
    config = conf.flutter_tools,
    ft = { "dart" },
  })

  use({
    "p00f/clangd_extensions.nvim",
    config = conf.clangd_extensions,
    ft = { "cpp", "c" },
  })

  use({
    "hbarral/vim-dadbod",
    cmd = {
      "DBUIToggle",
      "DBUI",
      "DBUIAddConnection",
      "DBUIFindBuffer",
      "DBUIRenameBuffer",
      "DBUILastQueryInfo",
    },
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
  })

  use({
    "dmmulroy/tsc.nvim",
    cmd = { "TSC" },
    config = true,
  })

  use({
    "pmizio/typescript-tools.nvim",
    ft = { "typescript", "typescriptreact" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
  })

  use({
    "vuki656/package-info.nvim",
    event = "BufEnter package.json",
    opts = {
      colors = {
        up_to_date = "#3C4048",
        outdated = "#fc514e",
      },
      icons = {
        enable = true,
        style = {
          up_to_date = icons.ui.CheckSquare,
          outdated = icons.git.Remove,
        },
      },
      autostart = true,
      hide_up_to_date = true,
      hide_unstable_versions = true,
      package_manager = "npm",
    },
  })

  use({
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    config = function()
      require("trouble").setup({})
    end,
  })

  use({
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup({
        symbol_in_winbar = {
          hide_keyword = true,
        },
        diagnostic = {
          show_code_action = false,
        },
      })
    end,
  })

  use({
    "hedyhli/outline.nvim",
    opts = {},
    cmd = { "Outline", "OutlineOpen" },
  })
end
