local handlers = require("SingularisArt.plugins.lsp.handlers")

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

    clangd = { require("SingularisArt.plugins.lsp.settings.clangd") },
    emmet_ls = { require("SingularisArt.plugins.lsp.settings.emmet_ls") },
    jsonls = { require("SingularisArt.plugins.lsp.settings.jsonls") },
    pyright = { require("SingularisArt.plugins.lsp.settings.pyright") },
    rust_analyzer = { require("SingularisArt.plugins.lsp.settings.rust_analyzer") },
    solang = { require("SingularisArt.plugins.lsp.settings.solang") },
    solc = { require("SingularisArt.plugins.lsp.settings.solc") },
    sumneko_lua = { require("SingularisArt.plugins.lsp.settings.sumneko_lua") },
    texlab = { require("SingularisArt.plugins.lsp.settings.texlab") },
    tsserver = { require("SingularisArt.plugins.lsp.settings.tsserver") },
    yamlls = { require("SingularisArt.plugins.lsp.settings.yamlls") },
    sqls = { require("SingularisArt.plugins.lsp.settings.sqls") },

    disable_lsp = {
      "pylsp",
      "ccls",
    },
    servers = {
      "bashls",
      "cssls",
      "cssmodules_ls",
      "tailwindcss",
      "html",
      "golangci_lint_ls",
      "jdtls",
      "solidity_ls",
    },
  },
})

-- require("SingularisArt.plugins.lsp.winbar")
