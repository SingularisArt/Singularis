local lsp = {}

local on_attach = function(client, bufnr)
  vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { buffer = true, silent = true })

  require("lsp-inlayhints").on_attach(client, bufnr)
end

local sql_on_attach = function(client, bufnr)
  on_attach(client, bufnr)

  require("sqls").on_attach(client, bufnr)
end

lsp.load = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- UI tweaks from https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
  local border = {
    { "╭", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╮", "FloatBorder" },
    { "│", "FloatBorder" },
    { "╯", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╰", "FloatBorder" },
    { "│", "FloatBorder" },
  }

  local servers = SingularisArt.lsp.config.servers

  local cmp_nvim_lsp = require("cmp_nvim_lsp")
  capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")
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
    ensure_installed = servers,
    automatic_installation = true,
  })

  local lspconfig = require("lspconfig")
  local opts = {}

  for _, server in ipairs(servers) do
    opts = {
      capabilities = capabilities,
      -- handlers = handlers,
      on_attach = on_attach,
    }

    server = vim.split(server, "@")[1]

    if server == "sqls" then
      local sqls_opts = require("SingularisArt.lsp.settings.sqls")
      opts = vim.tbl_deep_extend("force", sqls_opts, opts)

      opts.on_attach = sql_on_attach
    end

    if server == "sumneko_lua" then
      local sumneko_lua_opts = require("SingularisArt.lsp.settings.sumneko_lua")
      opts = vim.tbl_deep_extend("force", sumneko_lua_opts, opts)
    end

    lspconfig[server].setup(opts)
  end
end

return lsp
