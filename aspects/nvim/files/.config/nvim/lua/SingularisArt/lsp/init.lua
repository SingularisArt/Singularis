local lsp = {}
local icons = require("SingularisArt.icons")
local handlers = require("SingularisArt.lsp.handlers")

lsp.load = function()
  local signature_help_setup = {
    bind = true,
    doc_lines = 0,
    max_height = 10,
    max_width = 80,
    wrap = true,
    floating_window = true,
    floating_window_above_cur_line = true,
    floating_window_off_x = 1,
    floating_window_off_y = 0,
    fix_pos = false,
    hint_enable = true,
    hi_parameter = "LspSignatureActiveParameter",
    toggle_key = "<C-x>",
    hint_prefix = icons.misc.Squirrel .. " ",
    hint_scheme = "Comment",
    handler_opts = {
      border = "rounded",
    },
  }

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
    signature_help_cfg = nil,
    lsp_installer = false,
    mason = true,
    lsp_signature_help = signature_help_setup,

    on_attach = handlers.on_attach,

    icons = { icons = false },

    lsp = {
      enable = true,

      code_action = {
        delay = 3000,
        enable = false,
        sign = false,
        sign_priority = 40,
        virtual_text = false,
        virtual_text_icon = false,
      },
      code_lens_action = {
        enable = false,
        sign = false,
        sign_priority = 40,
        virtual_text = false,
        virtual_text_icon = false,
      },

      document_highlight = true,
      format_on_save = false,

      diagnostic = {
        underline = true,
        virtual_text = false,
        update_in_insert = false,
        severity_sort = { reverse = true },
      },

      disable_format_cap = {},
      diagnostic_virtual_text = false,
      diagnostic_update_in_insert = false,
      disply_diagnostic_qf = true,

      servers = {
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
      },
    },
  })

  require("SingularisArt.config.winbar")
end

return lsp
