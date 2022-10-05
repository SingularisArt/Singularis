local lsp = {}
local lspconfig = require("lspconfig")
local functions = SingularisArt.functions

lsp.load_server = function()
  local filetype = vim.bo.filetype
  local server = ""
  local filetypes = ""

  local opts = {
    on_attach = require("SingularisArt.lsp.handlers").on_attach,
    capabilities = require("SingularisArt.lsp.handlers").capabilities,
  }

  for _, table_info in pairs(SingularisArt.lsp.config.servers) do
    if type(table_info["filetype"]) == "table" then
      filetypes = table_info["filetype"]

      if functions.has_value(filetypes, filetype) then
        server = table_info["server"]
      end
    else
      if table_info["filetype"] == filetype then
        server = table_info["server"]
      end
    end
  end

  pcall(function()
    local other_opts = require("SingularisArt.lsp.settings." .. server)
    opts = vim.tbl_deep_extend("force", other_opts, opts)
  end)

  if server == "clangd" then
    opts.capabilities.offsetEncoding = { "utf-16" }
  end

  lspconfig[server].setup(opts)
  lspconfig[server].setup(opts)
end

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

  local filetype = ""
  local server = ""

  for _, server_table in pairs(servers) do
    filetype = server_table["filetype"]
    server = server_table["server"]

    if type(server) == "string" then
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = filetype,
        callback = function()
          vim.schedule(function()
            lsp.load_server()
          end)
        end,
      })
    end
  end
end

return lsp
