local lsp = {}

local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local mason_null_ls = require("mason-null-ls")
local mason_dap = require("mason-nvim-dap")
local servers = SingularisArt.lsp.config.servers

lsp.load_server = function(server)
  local opts = {
    on_attach = require("SingularisArt.lsp.handlers").on_attach,
    capabilities = require("SingularisArt.lsp.handlers").capabilities(),
  }

  pcall(function()
    local other_opts = require("SingularisArt.lsp.settings." .. server)
    opts = vim.tbl_deep_extend("force", other_opts, opts)
  end)

  if server == "clangd" then
    opts.capabilities.offsetEncoding = { "utf-16" }
  end

  lspconfig[server].setup(opts)
end

lsp.load = function()
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
  mason_lspconfig.setup({
    ensure_installed = nil,
    automatic_installation = true,
  })
  mason_null_ls.setup({
    ensure_installed = SingularisArt.lsp.config.ensure_installed_servers,
    automatic_installation = true,
    automatic_setup = false,
  })
  mason_dap.setup({
    ensure_installed = SingularisArt.lsp.config.ensure_installed_dap,
    automatic_installation = true,
    automatic_setup = false,
  })

  for _, server in ipairs(servers) do
    lsp.load_server(server)
  end
end

return lsp
