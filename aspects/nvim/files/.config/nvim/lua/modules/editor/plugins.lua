if vim.g.isInkscape then
  return function(_use) end
end

local default_coloumns = function(detailed)
  return detailed
  and {
    { "permissions", highlight = "String" },
    { "mtime", highlight = "Comment" },
    { "size", highlight = "Type" },
    "icon",
  }
  or { "icon" }
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

  -- Credit: https://github.com/elbkind/nvim/blob/main/lua/plugins/oil.lua
  ---
  use({
    "stevearc/oil.nvim",
    keys = {
      {
        "<leader>E",
        function()
          require("oil").open()
        end,
        desc = "File Explorer",
      },

      {
        "<leader>e",
        function()
          require("oil").open_float()
        end,
        desc = "File Browser",
      },

      {
        "<leader>fb",
        function()
          require("oil").toggle_float(vim.fn.getcwd())
        end,
        desc = "File Browser (CWD)",
      },

      {
        "<leader>fU",
        function()
          require("oil").toggle_float("~/Documents/school-notes/")
        end,
        desc = "University Folder",
      },

      {
        "<leader>fc",
        function()
          require("oil").toggle_float("~/Documents/school-notes/current-course/")
        end,
        desc = "University Folder (Current Course)",
      },
    },
    cmd = "Oil",
    opts = function(_, o)
      o.columns = default_coloumns(true)

      o.keymaps = {
        ["?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-k>"] = "k",
        ["<C-j>"] = "j",
        ["<C-l>"] = "actions.select",
        ["<C-s>"] = "actions.select_split",
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-o>"] = "actions.open_external",
        ["<C-T>"] = "actions.open_terminal",
        ["<C-c>"] = "actions.close",
        ["<C-b>"] = {
          desc = "Open UserDir",
          callback = function()
            require("oil").close()
            local home_dir = tostring(vim.fn.expand("$HOME"))
            require("oil").open_float(home_dir)
          end,
        },
        ["q"] = "actions.close",
        ["<Esc><Esc>"] = "actions.close",
        ["<C-h>"] = "actions.parent",
        ["<C-.>"] = "actions.toggle_hidden",
        ["g."] = "actions.toggle_hidden",
        ["-"] = "actions.parent",
        ["<C-w>"] = "actions.open_cwd",
        ["<C-x>"] = "actions.cd",
        ["g\\"] = "actions.toggle_trash",
        ["~"] = "actions.tcd",
        ["gs"] = {
          desc = "Save",
          callback = function()
            require("oil").save()
          end,
        },
        ["gr"] = "actions.refresh",
        ["gd"] = {
          desc = "Toggle detail view",
          callback = function()
            local oil = require("oil")
            local config = require("oil.config")
            if #config.columns == #default_coloumns(false) then
              oil.set_columns(default_coloumns(true))
            else
              oil.set_columns(default_coloumns(false))
            end
          end,
        },
      }
      o.use_default_keymaps = false
      o.silence_scp_warning = true -- disable scp warn to use oil-ssh since I'm using a remap
      o.view_options = {
        show_hidden = false,
        is_hidden_file = function(name, _)
          return vim.startswith(name, ".")
        end,
        is_always_hidden = function(name, _)
          local file_to_exclude = {
            [".DS_Store"] = true,
            ["Icon\r"] = true,
          }
          return file_to_exclude[name]
        end,
      }
      -- Configuration for the floating window in oil.open_float
      o.float = {
        -- Padding around the floating window
        padding = 0,
        max_width = 0,
        max_height = 16,
        border = "rounded",
        win_options = {
          winblend = 8,
        },
        override = function(conf)
          conf.row = (vim.o.lines - conf.height - 3)
          return conf
        end,
      }

      o.progress = {
        win_options = {
          winblend = 6,
        },
      }
      -- This are defaults for now, no need to override
      -- adapters = {
        --   ["oil://"] = "files",
        --   ["oil-ssh://"] = "ssh",
        -- },
        -- When opening the parent of a file, substitute these url schemes
        -- HACK:
        -- https://github.com/stevearc/oil.nvim/blob/931453fc09085c09537295c991c66637869e97e1/lua/oil/config.lua#L102~110
        -- Using this to remap url-scheme from args with oil-ssh schemes
        o.adapter_aliases = {
          ["ssh://"] = "oil-ssh://",
          ["scp://"] = "oil-ssh://",
          ["sftp://"] = "oil-ssh://",
        }
      end,
      init = function(p)
        if vim.fn.argc() == 1 then
          local argv = tostring(vim.fn.argv(0))
          local stat = vim.loop.fs_stat(argv)

          local remote_dir_args = vim.startswith(argv, "ssh") or vim.startswith(argv, "sftp") or vim.startswith(argv, "scp")

          if stat and stat.type == "directory" or remote_dir_args then
            require("lazy").load({ plugins = { p.name } })
          end
        end
        if not require("lazy.core.config").plugins[p.name]._.loaded then
          vim.api.nvim_create_autocmd("BufNew", {
            callback = function()
              if vim.fn.isdirectory(vim.fn.expand("<afile>")) == 1 then
                require("lazy").load({ plugins = { "oil.nvim" } })
                -- Once oil is loaded, we can delete this autocmd
                return true
              end
            end,
          })
        end
      end,
    })
    ---
end
