local conf = require("modules.completion.config")

return function(use)
  use({
    "hrsh7th/nvim-cmp",
    config = conf.cmp,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "kdheepak/cmp-latex-symbols",
      "quangnguyen30192/cmp-nvim-ultisnips",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-emoji",
      "f3fora/cmp-spell",
      "octaltree/cmp-look",
      {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        opts = function(_, opts)
          opts.formatting = {
            format = require("tailwindcss-colorizer-cmp").formatter,
          }
        end,
      },
      {
        "jalvesaq/cmp-nvim-r",
        config = function()
          require("cmp_zotcite").setup({
            filetypes = { "pandoc", "markdown", "rmd", "r", "quarto" }
          })
        end,
      },
      {
        "jalvesaq/cmp-zotcite",
        config = function()
          require("cmp_zotcite").setup({
            filetypes = { "pandoc", "markdown", "rmd", "r", "quarto" }
          })
        end,
        dependencies = "jalvesaq/zotcite",
      },
    },
    event = "InsertEnter",
  })

  use({
    "SirVer/ultisnips",
    after = "nvim-cmp",
    config = function()
      vim.g.UltiSnipsRemoveSelectModeMappings = 0
      vim.g.UltiSnipsEditSplit = "tabdo"
      vim.g.UltiSnipsSnippetDirectories = {
        "~/.config/nvim/UltiSnips", "UltiSnips"
      }
    end,
    event = "InsertEnter",
  })

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
    "windwp/nvim-autopairs",
    opts = {
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "vim" },
    },
    config = function()
      require("nvim-autopairs").setup({})

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
    event = "InsertEnter",
  })

  use({
    "nvim-telescope/telescope.nvim",
    config = conf.telescope,
    cmd = "Telescope",
    dependencies = {
      {
        "SingularisArt/telescope-sessions.nvim",
        config = function()
          require("telescope").setup({
            extensions = {
              sessions = {
                sessions = {
                  sessions_path = os.getenv("HOME") .. "/.config/nvim/misc/sessions/",
                  sessions_variable = "session",
                },
                dressing = true,
                autoload = false,
                autosave = true,
                autoswitch = {
                  enable = false,
                  exclude_ft = { "fugitive", "alpha", "NvimTree", "fzf", "qf" },
                },
                post_hook = nil,
              },
            },
          })

          require("telescope").load_extension("sessions")
        end,
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
    config = function()
      local cybu = require("cybu")

      cybu.setup({
        position = {
          relative_to = "win",
          anchor = "topright",
        },
        display_time = 1750,
        style = {
          path = "relative",
          border = "rounded",
          separator = " ",
          prefix = "…",
          padding = 1,
          hide_buffer_id = true,
          devicons = {
            enabled = true,
            colored = true,
          },
        },
      })

      vim.keymap.set("n", "H", "<Plug>(CybuPrev)")
      vim.keymap.set("n", "L", "<Plug>(CybuNext)")
    end,
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
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        relculright = false,
        ft_ignore = { "neo-tree" },
        segments = {
          {
            text = { " ", builtin.lnumfunc },
            condition = { true, builtin.not_empty },
            click = "v:lua.ScLa",
          },
          { text = { "%s" }, click = "v:lua.ScSa" },
          { text = { "%C", " " }, click = "v:lua.ScFa" },
        },
      })
      vim.api.nvim_create_autocmd({ "BufEnter" }, {
        callback = function()
          if vim.bo.filetype == "neo-tree" then
            vim.opt_local.statuscolumn = ""
          end
        end,
      })
    end,
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
    config = conf.neotree,
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
