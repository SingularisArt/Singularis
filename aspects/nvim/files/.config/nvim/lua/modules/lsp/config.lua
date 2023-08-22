local config = {}

function config.nvim_lsp()
  require("neoconf").setup()
  require("neodev").setup()

  local mason = require("mason-lspconfig")
  local conf = require("modules.lsp.lsp_config")
  local servers = conf.servers
  local icons = require("config.global").icons

  vim.diagnostic.config({
    virtual_text = false,
  })

  for name, icon in pairs(icons.diagnostics) do
    name = "DiagnosticSign" .. name
    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
  end

  local ensure_installed = {}
  for server, server_opts in pairs(servers) do
    if server_opts["install"] == true then
      local server_name = server_opts["install_server_name"] or server
      ensure_installed[#ensure_installed + 1] = server_name
    end
  end

  mason.setup({ ensure_installed = ensure_installed })
end

function config.navigator()
  local on_attach = require("modules.lsp.handlers").on_attach

  local nav_cfg = {
    debug = false,
    width = 0.75,
    height = 0.3,
    preview_height = 0.35,
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    ts_fold = false,
    default_mapping = false,
    treesitter_analysis = true,
    transparency = 50,
    on_attach = on_attach,

    lsp = {
      enable = true,
      code_action = { enable = false },
      code_lens_action = { enable = false },
      document_highlight = true,
      format_on_save = false,
      diagnostic = {
        underline = true,
        virtual_text = false,
        update_in_insert = false,
        severity_sort = { reverse = true },
      },
      disable_format_cap = { "stylua" },
      diagnostic_virtual_text = false,
      diagnostic_update_in_insert = false,
      disply_diagnostic_qf = true,
      emmet_ls = require("modules.lsp.settings.emmet_ls"),
      jsonls = require("modules.lsp.settings.jsonls"),
      pyright = require("modules.lsp.settings.pyright"),
      rust_analyzer = require("modules.lsp.settings.rust_analyzer"),
      solang = require("modules.lsp.settings.solang"),
      solc = require("modules.lsp.settings.solc"),
      lua_ls = require("modules.lsp.settings.lua_ls"),
      cssmodules_ls = { filetypes = { "css" } },
      dartls = { filetypes = { "dart" } },
      solargraph = { filetypes = { "ruby" } },
      tsserver = require("modules.lsp.settings.tsserver"),
      yamlls = require("modules.lsp.settings.yamlls"),
      sqlls = require("modules.lsp.settings.sqlls"),
      cssls = { filetypes = { "css" } },
      html = require("modules.lsp.settings.html"),
      texlab = require("modules.lsp.settings.texlab"),
      bashls = { filetypes = { "bash", "sh" } },
      clangd = require("modules.lsp.settings.clangd"),
      tailwindcss = {
        filetypes = {
          "html",
          "css",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact"
        },
      },
      golangci_lint_ls = { filetypes = { "go", "gomod" } },
      gopls = require("modules.lsp.settings.gopls"),
      jdtls = { filetypes = { "java" } },
      solidity_ls = { filetypes = { "solidity" }, install_server_name = "solidity" },
      r_language_server = { filetypes = { "r" } },
      lemminx = { filetypes = { "xml" } },
      marksman = { filetypes = { "markdown" } },
      zls = { filetypes = { "zig" } },
      ocamllsp = require("modules.lsp.settings.ocaml"),
    },
  }

  require("navigator").setup(nav_cfg)
end

function config.mason()
  require("mason").setup({
    ui = {
      border = "rounded",
      icons = {
        package_installed = "◍",
        package_pending = "◍",
        package_uninstalled = "◍",
      },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
  })
end

function config.mason_null_ls()
  local conf = require("modules.lsp.lsp_config")
  local formatters = conf.formatters
  local linters = conf.linters
  local code_actions = conf.code_actions

  local ensure_installed = {}
  for k, v in pairs(formatters) do
    if type(v) == "table" then
      table.insert(ensure_installed, k)
    else
      table.insert(ensure_installed, v)
    end
  end

  for k, v in pairs(linters) do
    if type(v) == "table" then
      table.insert(ensure_installed, k)
    else
      table.insert(ensure_installed, v)
    end
  end

  for k, v in pairs(code_actions) do
    if type(v) == "table" then
      table.insert(ensure_installed, k)
    else
      table.insert(ensure_installed, v)
    end
  end

  require("mason-null-ls").setup({
    ensure_installed = ensure_installed,
    automatic_installation = true,
  })
end

function config.signature()
end

function config.glance()
  local filter = require("util").filter
  local filterReactDTS = require("util").filter_react_dts

  require("glance").setup({
    hooks = {
      before_open = function(results, open, jump, method)
        if #results == 1 then
          jump(results[1])
        elseif method == "definitions" then
          results = filter(results, filterReactDTS)
          open(results)
        else
          open(results)
        end
      end,
    },
  })
end

return config
