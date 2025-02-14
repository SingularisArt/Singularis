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
    "christoomey/vim-tmux-navigator",
    event = "BufEnter",
  })

  use({
    "nvim-telescope/telescope.nvim",
    config = conf.telescope,
    cmd = "Telescope",
  })

  if not vim.g.isLATEX then
    use({
      "RRethy/vim-illuminate",
      -- "linrongbin16/vim-illuminate",
      config = function()
        require("illuminate").configure({
          delay = 200,
          filetypes_denylist = {
            "dirbuf",
            "dirvish",
            "fugitive",
            "TelescopePrompt",
            "toggleterm",
            "tex",
            "markdown",
          },
        })
      end,
      event = "BufRead",
    })
  end

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
    "mhinz/vim-grepper",
    cmd = {
      "Grepper",
      "GrepperAg",
      "GrepperGit",
      "GrepperGrep",
      "GrepperRg",
    },
  })

  use({
    "gelguy/wilder.nvim",
    build = ":UpdateRemotePlugins",
    config = function()
      local wilder = require("wilder")
      wilder.setup({ modes = { ":", "/", "?" } })
      wilder.set_option(
        "renderer",
        wilder.popupmenu_renderer({
          highlighter = wilder.basic_highlighter(),
        })
      )
    end,
    event = "CmdlineEnter",
  })
end
