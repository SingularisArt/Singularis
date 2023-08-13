return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("neoconf").setup()
      require("neodev").setup()

      local mason = require("mason-lspconfig")
      local lsp = require("lspconfig")

      local ext_capabilites = vim.lsp.protocol.make_client_capabilities()
      local capabilities = require("util").capabilities(ext_capabilites)

      local config = require("plugins.lsp.config")
      local servers = config.servers
      local on_attach = require("plugins.lsp.handlers").on_attach
      local icons = require("config.global").icons

      vim.diagnostic.config({
        virtual_text = false,
      })

      for name, icon in pairs(icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if not server_opts["on_attach"] then
          server_opts["on_attach"] = on_attach
        end

        lsp[server].setup(server_opts)
      end

      local ensure_installed = {}
      for server, server_opts in pairs(servers) do
        if server_opts["install"] == true then
          local server_name = server_opts["install_server_name"] or server
          ensure_installed[#ensure_installed + 1] = server_name
        end

        if server == "tsserver" then
          require("plugins.lsp.filetypes.typescript").typescript_tools(server_opts, on_attach)
        elseif server == "rust_analyzer" then
          local rt = require("rust-tools")
          server_opts.server.on_attach = on_attach

          rt.setup(server_opts)
        else
          setup(server)
        end
      end

      mason.setup({ ensure_installed = ensure_installed, automatic_installation = true })

      -- require("ufo").setup()
    end,
    dependencies = {
      "typescript-tools.nvim",
      "rust-tools.nvim",
      "clangd_extensions.nvim",
      -- "nvim-ufo",
      { "folke/neoconf.nvim", cmd = "Neoconf" },
      { "folke/neodev.nvim",  ft = "lua" },
      {
        "williamboman/mason-lspconfig.nvim",
        after = "mason.nvim",
        config = function()
          require("mason-lspconfig").setup()
        end,
      },
    },
    event = { "BufReadPre", "BufNewFile" },
  },

  {
    "SmiteshP/nvim-navic",
    event = "VeryLazy",
  },

  {
    "Fildo7525/pretty_hover",
    after = "nvim-lspconfig",
    config = function()
      require("pretty_hover").setup({})
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
    branch = "legacy",
    opts = {
      sources = {
        ["null-ls"] = { ignore = true },
      },
    },
    event = "BufEnter",
  },

  -- inlay hints
  {
    "simrat39/inlay-hints.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("inlay-hints").setup()
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
          local config = require("plugins.lsp.config")
          local formatters = config.formatters
          local linters = config.linters

          local ensure_installed = formatters

          for k, v in pairs(linters) do ensure_installed[k] = v end

          require("mason-null-ls").setup({
            ensure_installed = ensure_installed,
            automatic_installation = true,
          })
        end,
      },
    },
  },

  -- auto installer
  {
    "williamboman/mason.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("mason").setup({
        ui = {
          border = "none",
          icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
          },
        },
        log_level = vim.log.levels.INFO,
        max_concurrent_installers = 4,
      })
    end,
  },

  -- {
  --   "Bekaboo/dropbar.nvim",
  --   config = function()
  --     require("dropbar").setup({})
  --   end,
  --   event = { "BufReadPre", "BufNewFile" },
  -- },

  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
      require("lsp_lines").toggle()
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

  -- {
  --   "kevinhwang91/nvim-ufo",
  --   config = function()
  --     vim.keymap.set("n", "zR", require("ufo").openAllFolds)
  --     vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
  --     vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
  --   end,
  --   dependencies = "kevinhwang91/promise-async",
  --   event = "VeryLazy"
  -- },
}
