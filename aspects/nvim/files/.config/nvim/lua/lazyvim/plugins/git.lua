return {
  "sindrets/diffview.nvim",
  "AndrewRadev/linediff.vim",
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "ray-x/forgit.nvim",
  "TimUntersberger/neogit",
  "pwntester/octo.nvim",
  "mattn/vim-gist",

  {
    "akinsho/git-conflict.nvim",
    config = function()
      require("git-conflict").setup()
    end,
  },

  -- git signs
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

  -- TODO: DO THIS!
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
