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
    dependencies = {
      {
        "SingularisArt/telescope-sessions.nvim",
        config = conf.telescope_sessions,
        keys = {
          { "<Leader>Sl", "<CMD>Telescope sessions list<CR>" },
          { "<Leader>Sn", "<CMD>Telescope sessions new<CR>" },
          { "<Leader>Su", "<CMD>Telescope sessions update<CR>" },
        },
      },
    },
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
    "ThePrimeagen/harpoon",
    config = function()
      require("harpoon").setup()
      require("telescope").load_extension("harpoon")
    end,
    keys = {
      { "<Leader>Ha", "<CMD>lua require('harpoon.mark').add_file()<CR>" },
      { "<Leader>Hh", "<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>" },
      { "<Leader>Hn", "<CMD>lua require('harpoon.ui').nav_next()<CR>" },
      { "<Leader>Hp", "<CMD>lua require('harpoon.ui').nav_prev()<CR>" },
    },
  })

  use({
    "luukvbaal/statuscol.nvim",
    event = "BufReadPost",
    config = conf.statuscol,
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
    "epwalsh/obsidian.nvim",
    event = { "BufReadPre " .. vim.fn.expand("~") .. "/Documents/Obsidian/" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      dir = "~/Documents/Obsidian/",

      daily_notes = {
        folder = "notes/dailies",
        date_format = "%b %d %Y %a (%H:%M:%S)"
      },

      completion = {
        nvim_cmp = true,
        min_chars = 2,
        new_notes_location = "current_dir",
        prepend_note_id = true
      },
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
    config = true,
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
