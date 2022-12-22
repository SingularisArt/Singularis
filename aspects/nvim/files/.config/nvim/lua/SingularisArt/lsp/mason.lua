local lsp = {}
local handlers = require("SingularisArt.lsp.handlers")

local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local mason_null_ls = require("mason-null-ls")
local mason_dap = require("mason-nvim-dap")
local servers = {
  "bashls",
  "clangd",
  "cssls",
  "cssmodules_ls",
  "tailwindcss",
  "emmet_ls",
  "html",
  -- "golangci_lint_ls",
  -- "jdtls",
  -- "jsonls",
  "pyright",
  -- "rust_analyzer",
  -- "solang",
  -- "solc",
  -- "solidity_ls",
  -- "sqls",
  "texlab",
  -- "tsserver",
  "sumneko_lua",
  "yamlls",
}

lsp.load_server = function(server)
  local opts = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities(),
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
  mason_lspconfig.setup({ automatic_installation = true })
  mason_null_ls.setup({ automatic_installation = true })
  mason_dap.setup({
    automatic_installation = true,
    automatic_setup = true,
  })

  for _, server in ipairs(servers) do
    lsp.load_server(server)
  end
end

return lsp
