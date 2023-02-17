return {
  { "tpope/vim-fugitive", cmd = "Git" },

  {
    "AndrewRadev/linediff.vim",
    cmd = {
      "Linediff",
      "LinediffReset",
    },
  },

  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewFileHistory",
    },
  },

  { "TimUntersberger/neogit", cmd = "Neogit" },

  {
    "pwntester/octo.nvim",
    config = function()
      require("octo").setup()
    end,
    cmd = "Octo",
  },

  {
    "mattn/vim-gist",
    cmd = "Gist",
    dependencies = {
      "mattn/webapi-vim",
    },
  },

  {
    "akinsho/git-conflict.nvim",
    config = function()
      require("git-conflict").setup()
    end,
    cmd = {
      "GitConflictChooseOurs",
      "GitConflictChooseTheirs",
      "GitConflictChooseBoth",
      "GitConflictChooseNone",
      "GitConflictNextConflict",
      "GitConflictPrevConflict",
      "GitConflictListQf",
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local gitsigns = require("gitsigns")

      gitsigns.setup({
        signs = {
          add = {
            hl = "GitSignsAdd",
            text = "▎",
            numhl = "GitSignsAddNr",
            linehl = "GitSignsAddLn",
          },
          change = {
            hl = "GitSignsChange",
            text = "▎",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
          },
          delete = {
            hl = "GitSignsDelete",
            text = "契",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
          },
          topdelete = {
            hl = "GitSignsDelete",
            text = "契",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
          },
          changedelete = {
            hl = "GitSignsChange",
            text = "▎",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
          },
        },
        numhl = false,
        linehl = false,
        keymaps = {
          -- Default keymap options
          noremap = true,
          buffer = true,
        },
        signcolumn = true,
        word_diff = false,
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        -- current_line_blame_opts = {
        --   virt_text = true,
        --   virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        --   delay = 1000,
        --   ignore_whitespace = false,
        -- },
        -- current_line_blame_formatter_opts = {
        --   relative_time = false,
        -- },
        max_file_length = 40000,
        preview_config = {
          -- Options passed to nvim_open_win
          border = "rounded",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        sign_priority = 6,
        update_debounce = 200,
        status_formatter = nil,
        yadm = { enable = false },
      })
    end,
    event = "BufReadPre",
  },
}
