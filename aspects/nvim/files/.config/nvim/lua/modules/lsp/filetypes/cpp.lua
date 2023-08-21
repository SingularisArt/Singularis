local M = {}

M.clangd_extensions = function()
  require("clangd_extensions").setup({
    inlay_hints = {
      inline = vim.fn.has("nvim-0.10") == 1,
      only_current_line = false,
      only_current_line_autocmd = { "CursorHold" },
      show_parameter_hints = true,
      parameter_hints_prefix = "<- ",
      other_hints_prefix = "=> ",
      max_len_align = false,
      max_len_align_padding = 1,
      right_align = false,
      right_align_padding = 7,
      highlight = "Comment",
      priority = 100,
    },
    ast = {
      role_icons = {
        type = "",
        declaration = "",
        expression = "",
        specifier = "",
        statement = "",
        ["template argument"] = "",
      },
      kind_icons = {
        Compound = "",
        Recovery = "",
        TranslationUnit = "",
        PackExpansion = "",
        TemplateTypeParm = "",
        TemplateTemplateParm = "",
        TemplateParamObject = "",
      },
      highlights = {
        detail = "Comment",
      },
    },
    memory_usage = {
      border = "rounded",
    },
    symbol_info = {
      border = "rounded",
    },
  })

  local inlay_hints = require("clangd_extensions.inlay_hints")

  inlay_hints.setup_autocmd()
  inlay_hints.set_inlay_hints()
  inlay_hints.toggle_inlay_hints()
end

return M
