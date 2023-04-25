return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    config = function()
      for name, icon in pairs(require("config.global").icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end
    end,
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      { "folke/neodev.nvim",  opts = { experimental = { pathStrict = true } } },
    },
    event = { "BufReadPre", "BufNewFile" },
  },

  -- server configuration
  {
    "ray-x/navigator.lua",
    after = "nvim-lspconfig",
    config = function()
      require("plugins.lsp.navigator")
    end,
    event = { "BufReadPre", "BufNewFile" },
  },

  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("plugins.lsp.signature")
    end,
    event = { "BufReadPre", "BufNewFile" },
  },

  {
    "Fildo7525/pretty_hover",
    after = "nvim-lspconfig",
    config = function()
      require("pretty_hover").setup()
    end,
    event = { "BufReadPre", "BufNewFile" },
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
    opts = {
      sources = {
        ["null-ls"] = { ignore = true },
      },
    },
    event = "BufEnter",
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
    event = { "BufReadPre", "BufNewFile" },
  },

  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("plugins.lsp.null-ls")
    end,
    event = { "BufReadPre", "BufNewFile" },
    -- dependencies = "mason-null-ls.nvim",
  },

  -- auto installer
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          require("mason-lspconfig").setup({
            automatic_installation = true,
          })
        end
      },

      {
        "jay-babu/mason-null-ls.nvim",
        config = function()
          require("mason-null-ls").setup({
            automatic_installation = true,
          })
        end
      },

      {
        "jay-babu/mason-nvim-dap.nvim",
        config = function()
          require("mason-nvim-dap").setup({
            automatic_installation = true,
          })
        end
      },
    },
  },
}
