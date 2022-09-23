local lsp = {}

lsp.load = function()
  local servers = SingularisArt.lsp.config.servers

  local mason = require("mason")
  -- local mason_lspconfig = require("mason-lspconfig")

  local settings = {
    ui = {
      border = "rounded",
      icons = {
        package_installed = "◍",
        package_pending = "◍",
        package_uninstalled = "◍",
      },
    },
    max_concurrent_installers = 4,
  }

  mason.setup(settings)
  -- mason_lspconfig.setup({
  --   ensure_installed = servers,
  --   automatic_installation = true,
  -- })

  local lspconfig = require("lspconfig")

  local opts = {}

  for _, server in pairs(servers) do
    opts = {
      on_attach = require("SingularisArt.lsp.handlers").on_attach,
      capabilities = require("SingularisArt.lsp.handlers").capabilities,
    }

    server = vim.split(server, "@")[1]

    if server == "sumneko_lua" then
      local sumneko_lua_opts = require("SingularisArt.lsp.settings.sumneko_lua")
      opts = vim.tbl_deep_extend("force", sumneko_lua_opts, opts)
    end

    lspconfig[server].setup(opts)
  end
end

return lsp
