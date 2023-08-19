return {
  tools = {
    on_initialized = function()
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
        pattern = { "*.rs" },
        callback = function()
          vim.lsp.codelens.refresh()
        end,
      })
    end,

    auto = false,
    inlay_hints = {
      only_current_line = false,
      auto = true,

      only_current_line_autocmd = "CursorHold",

      show_parameter_hints = true,

      show_variable_name = true,

      max_len_align = false,
      max_len_align_padding = 1,
      right_align = false,
      right_align_padding = 7,
      highlight = "Comment",
    },
    hover_actions = {
      auto_focus = false,
      border = "rounded",
      width = 60,
    },
  },
  server = {
    cmd = { "/usr/bin/rust-analyzer" },
    settings = {
      ["rust-analyzer"] = {
        lens = {
          enable = true,
        },
        cargo = {
          allFeatures = true,
        },
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
  install = true,
}
