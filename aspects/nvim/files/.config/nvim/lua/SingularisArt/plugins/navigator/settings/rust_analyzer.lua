return {
  tools = {
    -- autoSetHints = false,
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
      auto = false,

      only_current_line_autocmd = "CursorHold",

      show_parameter_hints = true,

      show_variable_name = false,

      parameter_hints_prefix = " ",

      other_hints_prefix = " ",
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
    --[[
        $ mkdir -p ~/.local/bin
        $ curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
        $ chmod +x ~/.local/bin/rust-analyzer
    --]]
    -- cmd = { os.getenv "HOME" .. "/.local/bin/rust-analyzer" },
    cmd = { "rustup", "run", "nightly", os.getenv("HOME") .. "/.local/bin/rust-analyzer" },

    settings = {
      ["rust-analyzer"] = {
        lens = {
          enable = true,
        },
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
}
