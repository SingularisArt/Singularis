return {
  {
    "AndrewRadev/linediff.vim",
    cmd = {
      "Linediff",
      "LinediffReset",
    },
  },

  -- { "tpope/vim-rhubarb", cmd = "GBrowse" },

  { "tpope/vim-fugitive", cmd = "Git" },

  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewFileHistory",
    },
  },

  {
    "ray-x/forgit.nvim",
    config = function()
      require("forgit").setup({
        debug = false,
        diff = "delta",
        fugitive = false,
        git_alias = true,
        show_result = "quickfix",

        shell_mode = true,
        height_ratio = 0.6,
        width_ratio = 0.6,
      })
    end,
  },

  {
    "TimUntersberger/neogit",
    cmd = "Neogit",
  },

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
    event = "BufReadPre",
    config = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "契" },
        topdelete = { text = "契" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
    },
  },

  {
    "ThePrimeagen/git-worktree.nvim",
    config = function()
      local function git_worktree(arg)
        if arg == "create" then
          require("telescope").extensions.git_worktree.create_git_worktree()
        else
          require("telescope").extensions.git_worktree.git_worktrees()
        end
      end

      require("git-worktree").setup({})
      vim.api.nvim_create_user_command("Worktree", "lua require'modules.tools.config'.worktree()(<f-args>)", {
        nargs = "*",
        complete = function()
          return { "create" }
        end,
      })

      local Worktree = require("git-worktree")
      Worktree.on_tree_change(function(op, metadata)
        if op == Worktree.Operations.Switch then
          print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
        end

        if op == Worktree.Operations.Create then
          print("Create worktree " .. metadata.path)
        end

        if op == Worktree.Operations.Delete then
          print("Delete worktree " .. metadata.path)
        end
      end)
      return { git_worktree = git_worktree }
    end,
  },
}
