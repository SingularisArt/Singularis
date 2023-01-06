return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = "BufEnter",
    dependencies = {
      "SmiteshP/nvim-navic",
    },
    config = function()
      -- diagnostics
      for name, icon in pairs(require("lazyvim.config.icons").diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end
    end,
  },

  -- server configuration
  {
    "ray-x/navigator.lua",
    after = "nvim-lspconfig",
    event = "BufEnter",
    config = function()
      require("lazyvim.plugins.lsp.navigator")
    end,
    dependencies = {
      "ray-x/guihua.lua",
      {
        "ray-x/lsp_signature.nvim",
        config = function()
          local icons = require("lazyvim.config.icons")

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
      },
    },
  },

  -- formatters
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   event = "BufEnter",
  --   config = function()
  --     require("lazyvim.plugins.lsp.null-ls")
  --   end,
  -- },

  -- auto installer
  -- {
  --   "williamboman/mason.nvim",
  --   config = function()
  --     require("mason").setup()
  --   end,
  --   dependencies = {
  --     {
  --       "williamboman/mason-lspconfig.nvim",
  --       config = function()
  --         require("mason-lspconfig").setup({
  --           automatic_installation = true,
  --         })
  --       end
  --     },
  --     {
  --       "jay-babu/mason-nvim-dap.nvim",
  --       config = function()
  --         require("mason-nvim-dap").setup({
  --           automatic_installation = true,
  --         })
  --       end
  --     },
  --     {
  --       "jay-babu/mason-null-ls.nvim",
  --       config = function()
  --         require("mason-null-ls").setup({
  --           automatic_installation = true,
  --         })
  --       end
  --     },
  --   },
  -- },

  -- {
  --   "glepnir/lspsaga.nvim",
  --   config = function()
  --     require("lspsaga").init_lsp_saga({
  --       border_style = "rounded",
  --       code_action_lightbulb = {
  --         enable = false,
  --       },
  --       symbol_in_winbar = {
  --         enable = true,
  --       },
  --     })
  --   end,
  --   cmd = {
  --     "Lspsaga",
  --   },
  -- },

  -- {
  --   "simrat39/symbols-outline.nvim",
  --   config = function()
  --     require("symbols-outline").setup()
  --   end,
  --   cmd = {
  --     "SymbolsOutline",
  --     "SymbolsOutlineOpen",
  --   },
  --   lazy = true,
  -- },

  -- {
  --   "kosayoda/nvim-lightbulb",
  --   config = function()
  --     require("nvim-lightbulb").setup({
  --       autocmd = {
  --         enabled = true,
  --       },
  --     })
  --   end,
  -- },
}
