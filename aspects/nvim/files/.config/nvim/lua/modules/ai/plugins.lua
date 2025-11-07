if vim.g.isInkscape then
  return function(_use) end
end

return function(use)
  use({
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<leader>ch",
          },
          layout = {
            position = "bottom",
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<C-h>",
            accept_line = "<C-o>",
            next = false,
            prev = false,
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          oil = false,
          help = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          VimspectorPrompt = false,
          TelescopePrompt = false,
          AvanteInput = false,
          Avante = false,
          ["."] = false,
        },
        copilot_node_command = "node",
        server_opts_overrides = {},
      })
    end,
  })
end
