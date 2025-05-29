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
    keys = {
      { "<Leader>sk", "<CMD>Telescope keymaps<CR>", desc = "Fuzzy find keymaps (TELESCOPE)." },
      { "<Leader>so", "<CMD>Telescope git_status<CR>", desc = "Open changed file (TELESCOPE)." },
      { "<Leader>sb", "<CMD>Telescope git_branches<CR>", desc = "Checkout branch (TELESCOPE)." },
      { "<Leader>sc", "<CMD>Telescope git_commits<CR>", desc = "Checkout commit (TELESCOPE)." },
      { "<Leader>sC", "<CMD>Telescope git_bcommits<CR>", desc = "Checkout commit (TELESCOPE)." },
      { "<Leader>sf", "<CMD>Telescope find_files<CR>", desc = "Fuzzy find files (TELESCOPE)." },
      { "<Leader>sg", "<CMD>Telescope grep_string<CR>", desc = "Fuzzy find string (TELESCOPE)." },
      { "<Leader>sb", "<CMD>Telescope buffers<CR>", desc = "Fuzzy find buffers (TELESCOPE)." },
      { "<Leader>sl", "<CMD>Telescope live_grep<CR>", desc = "Fuzzy find words (TELESCOPE)." },
      { "<Leader>ss", "<CMD>Telescope symbols<CR>", desc = "Fuzzy find symbols (TELESCOPE)." },
      { "<Leader>sh", "<CMD>Telescope help_tags<CR>", desc = "View help tags (TELESCOPE)." },
      { "<Leader>sd", "<CMD>Telescope diagnostics<CR>", desc = "Fuzzy find diagnostics (TELESCOPE)." },
      {
        "<Leader>sw",
        function()
          local word = vim.fn.expand("<cword>")
          local builtin = require('telescope.builtin')
          builtin.grep_string({ search = word })
        end, desc = "Fuzzy find word under cursor (TELESCOPE).",
      },
      {
        "<Leader>sW",
        function()
          local word = vim.fn.expand("<cWORD>")
          local builtin = require('telescope.builtin')
          builtin.grep_string({ search = word })
        end, desc = "Fuzzy find WORD under cursor (TELESCOPE).",
      },
    },
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

  use({
    "wincent/ferret",
    cmd = {
      "Ack",
      -- "Ack!",
      -- "Lack",
      -- "Lack!",
      -- "Back",
      -- "Back!",
      -- "Black",
      -- "Black!",
      -- "Quack",
      -- "Quack!",
      -- "Acks",
      -- "Lacks",
      -- "FerretCancelAsync",
      -- "FerretPullAsync",
      -- "Qargs",
    }
  })
end
