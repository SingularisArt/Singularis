local icons = require("SingularisArt.icons")
local handlers = require("SingularisArt.plugins.navigator.handlers")

local signs = {
  { name = "DiagnosticSignError", text = icons.diagnostics.Error },
  { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
  { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
  { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
}
for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

require("navigator").setup({
  debug = false,
  width = 0.75,
  height = 0.3,
  preview_height = 0.35,
  border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  ts_fold = false,
  default_mapping = false,
  treesitter_analysis = true,
  treesitter_analysis_max_num = 100,
  treesitter_analysis_condense = true,
  transparency = 50,
  lsp_installer = false,
  mason = true,

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

    clangd = { require("SingularisArt.plugins.navigator.settings.clangd") },
    emmet_ls = { require("SingularisArt.plugins.navigator.settings.emmet_ls") },
    jsonls = { require("SingularisArt.plugins.navigator.settings.jsonls") },
    pyright = { require("SingularisArt.plugins.navigator.settings.pyright") },
    rust_analyzer = { require("SingularisArt.plugins.navigator.settings.rust_analyzer") },
    solang = { require("SingularisArt.plugins.navigator.settings.solang") },
    solc = { require("SingularisArt.plugins.navigator.settings.solc") },
    sumneko_lua = { require("SingularisArt.plugins.navigator.settings.sumneko_lua") },
    texlab = { require("SingularisArt.plugins.navigator.settings.texlab") },
    tsserver = { require("SingularisArt.plugins.navigator.settings.tsserver") },
    yamlls = { require("SingularisArt.plugins.navigator.settings.yamlls") },
    sqls = { require("SingularisArt.plugins.navigator.settings.sqls") },

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

require("SingularisArt.modules.lang.winbar")
