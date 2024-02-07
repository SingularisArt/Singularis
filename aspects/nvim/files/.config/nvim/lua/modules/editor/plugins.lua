if vim.g.isInkscape then
  return function(_use) end
end

local conf = require("modules.editor.config")

return function(use)
  use({
    "numToStr/Comment.nvim",
    opts = { ignore = "^$" },
    lazy = false,
  })

  use({
    "folke/todo-comments.nvim",
    config = conf.todo_comments,
    event = "BufRead",
  })

  use({ "wakatime/vim-wakatime", event = "BufEnter" })

  use({
    "christoomey/vim-tmux-navigator",
    event = "BufEnter",
  })

  use({
    "nvim-telescope/telescope.nvim",
    config = conf.telescope,
    cmd = "Telescope",
  })

  use({
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure({ delay = 200 })
    end,
    event = "BufRead",
  })

  use({
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end,
    event = "CmdlineEnter",
  })

  use({
    "kevinhwang91/nvim-bqf",
    config = function()
      require("bqf").setup()
    end,
    dependencies = {
      {
        "junegunn/fzf",
        run = function()
          vim.fn["fzf#install"]()
        end,
      },
    },
    ft = "qf",
  })

  use({
    "mbbill/undotree",
    config = function()
      vim.cmd([[
      if has("persistent_undo")
        let target_path = expand("~/.config/nvim/misc/undo")

        " create the directory and any parent directories
        " if the location does not exist.
        if !isdirectory(target_path)
          call mkdir(target_path, "p", 0700)
        endif

        let &undodir=target_path
        set undofile
      endif
    ]])
    end,
    cmd = "UndotreeToggle",
  })

  use({
    "ghillb/cybu.nvim",
    config = conf.cybu,
    keys = {
      "H",
      "L",
    },
  })

  use({
    "rmagatti/alternate-toggler",
    config = function()
      require("alternate-toggler").setup({})
    end,
    keys = {
      { "<Space>t", "<CMD>lua require('alternate-toggler').toggleAlternate()<CR>" },
    },
  })

  use({
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    config = conf.neo_tree,
    dependencies = "MunifTanjim/nui.nvim",
    keys = {
      { "<Leader>e", "<CMD>Neotree toggle<CR>" },
    },
  })

  use({
    "tamago324/lir.nvim",
    config = conf.lir,
    keys = {
      { "<Leader>-", "<CMD>lua require('lir.float').toggle()<CR>" },
    },
  })

  use({
    "AckslD/muren.nvim",
    cmd = {
      "MurenToggle",
      "MurenOpen",
      "MurenClose",
      "MurenFresh",
      "MurenUnique",
    },
  })
end
