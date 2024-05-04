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
    "ThePrimeagen/harpoon",
    opts = {},
    keys = {
      { "L", function() require("harpoon.ui").nav_next() end },
      { "H", function() require("harpoon.ui").nav_prev() end },
      { "<Leader>pt", "<CMD>Telescope harpoon marks<CR>" },
      { "<Leader>pa", function() require("harpoon.mark").add_file() end },
      { "<Leader>pu", function() require("harpoon.ui").toggle_quick_menu() end },
      { "<Leader>p1", function() require("harpoon.ui").nav_file(1) end },
      { "<Leader>p2", function() require("harpoon.ui").nav_file(2) end },
      { "<Leader>p3", function() require("harpoon.ui").nav_file(3) end },
      { "<Leader>p4", function() require("harpoon.ui").nav_file(4) end },
      { "<Leader>p5", function() require("harpoon.ui").nav_file(5) end },
      { "<Leader>p6", function() require("harpoon.ui").nav_file(6) end },
      { "<Leader>p7", function() require("harpoon.ui").nav_file(7) end },
      { "<Leader>p8", function() require("harpoon.ui").nav_file(8) end },
      { "<Leader>p9", function() require("harpoon.ui").nav_file(9) end },
    },
  })

  use({
    "rmagatti/alternate-toggler",
    config = function()
      require("alternate-toggler").setup({})
    end,
    keys = {
      { "<Leader>t", function() require("alternate-toggler").toggleAlternate() end },
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
end
