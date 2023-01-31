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
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "yaml",
  "sql",
  "sh",
  "go",
  "gomod",
  "java",
  "r",
  "bib",
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
      require("lazyvim.plugins.lsp.signature")
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
    -- after = "nvim-lspconfig",
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
    keys = "<Leader>lf",
  },
}
