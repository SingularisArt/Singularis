local conf = require("modules.git.config")

return function(use)
  use({ "tpope/vim-fugitive", cmd = "Git" })
  use({ "rhysd/git-messenger.vim", cmd = "GitMessenger" })

  use({
    "AndrewRadev/linediff.vim",
    cmd = {
      "Linediff",
      "LinediffReset",
    },
  })

  use({
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewFileHistory",
    },
  })

  use({ "NeogitOrg/neogit", cmd = "Neogit" })

  use({
    "pwntester/octo.nvim",
    config = function()
      require("octo").setup()
    end,
    cmd = "Octo",
  })

  use({
    "mattn/vim-gist",
    cmd = "Gist",
    dependencies = {
      "mattn/webapi-vim",
    },
  })

  use({
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
  })

  use({
    "lewis6991/gitsigns.nvim",
    config = conf.gitsigns,
  })
end
