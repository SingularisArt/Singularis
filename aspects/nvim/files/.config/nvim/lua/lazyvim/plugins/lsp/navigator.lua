local handlers = require("lazyvim.plugins.lsp.handlers")
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true

local html_capabilities = capabilities
local css_capabilities = capabilities
capabilities.offsetEncoding = { "utf-32" }
local clangd_capabilities = capabilities

require("navigator").setup({
  debug = false,
  width = 0.75,
  height = 0.3,
  preview_height = 0.35,
  border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  ts_fold = false,
  default_mapping = false,
  treesitter_analysis = true,
  transparency = 50,

  on_attach = handlers.on_attach,

  icons = { icons = false },

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

    emmet_ls = { require("lazyvim.plugins.lsp.settings.emmet_ls") },
    jsonls = { require("lazyvim.plugins.lsp.settings.jsonls") },
    pyright = { require("lazyvim.plugins.lsp.settings.pyright") },
    rust_analyzer = { require("lazyvim.plugins.lsp.settings.rust_analyzer") },
    solang = { require("lazyvim.plugins.lsp.settings.solang") },
    solc = { require("lazyvim.plugins.lsp.settings.solc") },
    sumneko_lua = { require("lazyvim.plugins.lsp.settings.sumneko_lua") },
    texlab = { require("lazyvim.plugins.lsp.settings.texlab"), filetype = { "bib" } },
    tsserver = { require("lazyvim.plugins.lsp.settings.tsserver") },
    yamlls = { require("lazyvim.plugins.lsp.settings.yamlls") },
    sqls = { require("lazyvim.plugins.lsp.settings.sqls") },
    html = {
      require("lazyvim.plugins.lsp.settings.html"),
      capabilities = html_capabilities,
    },
    cssls = { capabilities = css_capabilities },

    disable_lsp = {
      "pylsp",
      "ccls",
      "denols",
      "flow",
    },

    servers = {
      "bashls",
      "clangd",
      "cssmodules_ls",
      "tailwindcss",
      "golangci_lint_ls",
      "jdtls",
      "solidity_ls",
      "r_language_server",
    },
  },
})
