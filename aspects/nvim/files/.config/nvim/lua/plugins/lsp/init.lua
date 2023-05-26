return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = 'v2.x',
    config = function()
      vim.diagnostic.config({
        virtual_text = false,
      })

      require("lsp-zero.settings").preset({
        float_border = "none",
      })
    end
  },

  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lsp = require("lsp-zero")
      local servers = require("plugins.lsp.servers")
      local lspconfig = require("lspconfig")
      local lsp_defaults = lspconfig.util.default_config

      local diagnostic_icons = require("config.global").icons.diagnostics
      local on_attach = require("plugins.lsp.handlers").on_attach

      lsp.ensure_installed = {}

      lsp_defaults.capabilities = vim.tbl_deep_extend(
        "force",
        lsp_defaults.capabilities,
        require("cmp_nvim_lsp").default_capabilities()
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(lsp_defaults.capabilities),
        }, servers[server] or {})

        require("lspconfig")[server].setup(server_opts)
      end

      lsp.on_attach(function(client, bufnr)
        on_attach(client, bufnr)
      end)

      lsp.set_sign_icons({
        error = diagnostic_icons.Error,
        warn = diagnostic_icons.Warn,
        hint = diagnostic_icons.Hint,
        info = diagnostic_icons.Info,
      })

      local ensure_installed = {}
      local available = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)

      for server, server_opts in pairs(servers) do
        if server_opts then
          if not vim.tbl_contains(available, server) then
            setup(server)
          else
            if server_opts["install"] then
              ensure_installed[#ensure_installed + 1] = server
            end
          end
        end
      end

      require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
      require("mason-lspconfig").setup_handlers({ setup })

      lsp.setup()
    end,
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      {
        "folke/neodev.nvim",
        opts = {
          experimental = { pathStrict = true } }
      },
      {
        "williamboman/mason-lspconfig.nvim",
        after = "mason.nvim",
        config = function()
          require("mason-lspconfig").setup({
            automatic_installation = true,
          })
        end
      },
    },
    event = { "BufReadPre", "BufNewFile" },
  },

  { "SmiteshP/nvim-navic", event = "VeryLazy" },

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
    dependencies = {
      {
        "jay-babu/mason-null-ls.nvim",
        after = "mason.nvim",
        config = function()
          require("mason-null-ls").setup({
            automatic_installation = true,
          })
        end,
      }
    },
  },

  -- auto installer
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
}
