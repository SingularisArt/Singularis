return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    config = function()
      local on_attach = require("plugins.lsp.handlers").on_attach

      for name, icon in pairs(require("config.global").icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end

      local servers = require("plugins.lsp.servers")
      local ext_capabilites = vim.lsp.protocol.make_client_capabilities()
      local capabilities = require("util").capabilities(ext_capabilites)

      local function setup(server)
        if servers[server] and servers[server].disabled then
          return
        end

        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if not server_opts["on_attach"] then
          server_opts["on_attach"] = on_attach
        end

        require("lspconfig")[server].setup(server_opts)
      end

      local available = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)

      local ensure_installed = {}
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
