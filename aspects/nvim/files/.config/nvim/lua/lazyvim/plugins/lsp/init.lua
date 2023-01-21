local lsp_filetypes = {
  "c",
  "cpp",
  "html",
  "css",
  "json",
  "python",
  "rust",
  "solidity",
  "lua",
  "js",
  "ts",
  "yaml",
  "sql",
  "sh",
  "go",
  "gomod",
  "java",
  "r",
}

return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- diagnostics
      for name, icon in pairs(require("lazyvim.config.global").icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end
    end,
    dependencies = {
      "SmiteshP/nvim-navic",

      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          require("mason-lspconfig").setup({
            automatic_installation = true,
          })
        end,
        dependencies = "williamboman/mason.nvim",
      },

      {
        "folke/neodev.nvim",
        config = function()
          require("neodev").setup()
        end,
        ft = "lua",
      },
    },
    ft = lsp_filetypes,
  },

  -- server configuration
  {
    "ray-x/navigator.lua",
    after = "nvim-lspconfig",
    config = function()
      require("lazyvim.plugins.lsp.navigator")
    end,
    ft = lsp_filetypes,
  },

  {
    "ray-x/lsp_signature.nvim",
    config = function()
      local icons = require("lazyvim.config.global").icons

      local signature_help_setup = {
        bind = true,
        doc_lines = 0,
        max_height = 10,
        max_width = 80,
        wrap = true,
        floating_window = true,
        floating_window_above_cur_line = true,
        floating_window_off_x = 1,
        floating_window_off_y = 0,
        fix_pos = false,
        hint_enable = true,
        hi_parameter = "LspSignatureActiveParameter",
        toggle_key = "<C-x>",
        hint_prefix = icons.misc.Squirrel .. " ",
        hint_scheme = "Comment",
        handler_opts = {
          border = "rounded",
        },
      }

      require("lsp_signature").setup(signature_help_setup)
    end,
    ft = lsp_filetypes,
  },

  {
    "glepnir/lspsaga.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("lspsaga").setup({
        border_style = "rounded",
        lightbulb = {
          enable = false,
          enable_in_insert = false,
          sign = false,
          sign_priority = 40,
          virtual_text = false,
        },
        symbol_in_winbar = {
          enable = true,
        },
      })
    end,
    ft = lsp_filetypes,
  },

  {
    "simrat39/symbols-outline.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("symbols-outline").setup()
    end,
    cmd = {
      "SymbolsOutline",
      "SymbolsOutlineOpen",
    },
  },

  {
    "j-hui/fidget.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("fidget").setup({
        sources = {
          ["null-ls"] = { ignore = true },
        },
      })
    end,
    ft = lsp_filetypes,
  },

  {
    "lvimuser/lsp-inlayhints.nvim",
    after = "nvim-lspconfig",
    config = function()
      local setup = {
        inlay_hints = {
          parameter_hints = {
            show = true,
            separator = ", ",
          },
          type_hints = {
            show = true,
            prefix = "",
            separator = ", ",
            remove_colon_end = false,
            remove_colon_start = false,
          },
          labels_separator = "  ",
          max_len_align = false,
          max_len_align_padding = 1,
          right_align = false,
          right_align_padding = 7,
          highlight = "Comment",
        },
        debug_mode = false,
      }

      require("lsp-inlayhints").setup(setup)
    end,
    ft = lsp_filetypes,
  },

  {
    "folke/neoconf.nvim",
    -- after = "nvim-lspconfig",
    config = function()
      require("neoconf").setup()
    end,
    ft = { "lua", "json" },
    -- cmd = "Neoconf",
  },

  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("lazyvim.plugins.lsp.null-ls")
    end,
    dependencies = {
      {
        "jay-babu/mason-null-ls.nvim",
        config = function()
          require("mason-null-ls").setup({
            automatic_installation = true,
          })
        end,
        dependencies = "williamboman/mason.nvim",
      },
    },
    keys = "<Leader>lf",
  },

  -- auto installer
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
}
