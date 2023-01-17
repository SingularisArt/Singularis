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
    },
    event = "BufEnter",
  },

  -- -- server configuration
  -- {
  --   "ray-x/navigator.lua",
  --   after = "nvim-lspconfig",
  --   config = function()
  --     require("lazyvim.plugins.lsp.navigator")
  --   end,
  --   dependencies = {
  --     {
  --       "ray-x/lsp_signature.nvim",
  --       config = function()
  --         local icons = require("lazyvim.config.global").icons

  --         local signature_help_setup = {
  --           bind = true,
  --           doc_lines = 0,
  --           max_height = 10,
  --           max_width = 80,
  --           wrap = true,
  --           floating_window = true,
  --           floating_window_above_cur_line = true,
  --           floating_window_off_x = 1,
  --           floating_window_off_y = 0,
  --           fix_pos = false,
  --           hint_enable = true,
  --           hi_parameter = "LspSignatureActiveParameter",
  --           toggle_key = "<C-x>",
  --           hint_prefix = icons.misc.Squirrel .. " ",
  --           hint_scheme = "Comment",
  --           handler_opts = {
  --             border = "rounded",
  --           },
  --         }

  --         require("lsp_signature").setup(signature_help_setup)
  --       end,
  --     },
  --   },
  --   event = "BufEnter",
  -- },

  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("lazyvim.plugins.lsp.null-ls")
    end,
    event = "BufEnter",
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
        end,
      },
      {
        "jay-babu/mason-nvim-dap.nvim",
        config = function()
          require("mason-nvim-dap").setup({
            automatic_installation = true,
          })
        end,
      },
      {
        "jay-babu/mason-null-ls.nvim",
        config = function()
          require("mason-null-ls").setup({
            automatic_installation = true,
          })
        end,
      },
    },
    event = "VeryLazy",
  },

  {
    "glepnir/lspsaga.nvim",
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
    event = "BufRead",
  },

  {
    "simrat39/symbols-outline.nvim",
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
    config = function()
      require("fidget").setup({
        sources = {
          ["null-ls"] = { ignore = true },
        },
      })
    end,
    event = "BufEnter",
  },

  { "lvimuser/lsp-inlayhints.nvim", lazy = false },
}
