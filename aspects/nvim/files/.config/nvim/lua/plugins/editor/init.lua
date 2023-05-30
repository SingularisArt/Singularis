return {
  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    config = function()
      require("plugins.editor.neotree")
    end,
    dependencies = "MunifTanjim/nui.nvim",
    keys = {
      { "<Leader>e", "<CMD>Neotree toggle<CR>" },
    },
  },

  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    config = function()
      require("oil").setup()
    end,
    keys = {
      { "<Leader>o", "<CMD>Oil<CR>" },
    },
  },

  -- floating file explorer
  {
    "tamago324/lir.nvim",
    config = function()
      local lir = require("lir")

      local actions = require("lir.actions")
      local mark_actions = require("lir.mark.actions")
      local clipboard_actions = require("lir.clipboard.actions")

      lir.setup({
        show_hidden_files = false,
        devicons = { enable = true },
        mappings = {
          ["<cr>"] = actions.edit,
          ["l"] = actions.edit,
          ["<C-s>"] = actions.split,
          ["v"] = actions.vsplit,
          ["<C-t>"] = actions.tabedit,
          ["h"] = actions.up,
          ["q"] = actions.quit,
          ["A"] = actions.mkdir,
          ["a"] = actions.newfile,
          ["r"] = actions.rename,
          ["@"] = actions.cd,
          ["Y"] = actions.yank_path,
          ["i"] = actions.toggle_show_hidden,
          ["d"] = actions.delete,
          ["J"] = function()
            mark_actions.toggle_mark()
            vim.cmd("normal! j")
          end,
          ["c"] = clipboard_actions.copy,
          ["x"] = clipboard_actions.cut,
          ["p"] = clipboard_actions.paste,
        },
        float = {
          winblend = 0,
          curdir_window = {
            enable = false,
            highlight_dirname = true,
          },
          -- -- You can define a function that returns a table to be passed as the third
          -- -- argument of nvim_open_win().
          win_opts = function()
            local width = math.floor(vim.o.columns * 0.7)
            local height = math.floor(vim.o.lines * 0.7)
            return {
              border = "rounded",
              width = width,
              height = height,
              -- row = 1,
              -- col = math.floor((vim.o.columns - width) / 2),
            }
          end,
        },
        hide_cursor = false,
        on_init = function()
          -- use visual mode
          vim.api.nvim_buf_set_keymap(
            0,
            "x",
            "J",
            ":<C-u>lua require('lir.mark.actions').toggle_mark('v')<CR>",
            { noremap = true, silent = true }
          )
        end,
      })

      -- custom folder icon
      require("nvim-web-devicons").set_icon({
        lir_folder_icon = {
          icon = "",
          color = "#42A5F5",
          name = "LirFolderNode",
        },
      })
    end,
    keys = {
      { "<Leader>-", "<CMD>lua require('lir.float').toggle()<CR>" },
    },
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("plugins.editor.telescope")
    end,
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
  },

  -- references
  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure({ delay = 200 })
    end,
    event = "BufRead",
  },

  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup()
    end,
    cmd = {
      "Trouble",
      "TroubleClose",
      "TroubleToggle",
      "TroubleRefresh",
    },
  },

  {
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end,
    event = "CmdlineEnter",
  },

  {
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
  },

  {
    "kevinhwang91/nvim-ufo",
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ("  %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end
      local whitelist = {
        ["gotmpl"] = "indent",
        ["python"] = "lsp",
        ["html"] = "indent",
      }
      require("ufo").setup({
        provider_selector = function(bufnr, filetype)
          if whitelist[filetype] then
            return whitelist[filetype]
          end
          return ""
        end,
      })
      local bufnr = vim.api.nvim_get_current_buf()
      local ft = vim.o.ft
      if whitelist[ft] then
        require("ufo").setVirtTextHandler(bufnr, handler)
      end
    end,
    dependencies = "kevinhwang91/promise-async",
    lazy = false,
  },

  {
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
  },

  {
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
  },

  -- Copilot
  {
    "github/copilot.vim",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap("i", "<C-h>", "copilot#Accept('<CR>')", { silent = true, expr = true })

      vim.g.copilot_filetypes = {
        -- ["*"] = false,
        -- ["python"] = true,
        -- ["c++"] = true,
        -- ["c#"] = true,
        -- ["c"] = true,
        -- ["sql"] = true,
        -- ["html"] = true,
        -- ["css"] = true,
        -- ["javascript"] = true,
        -- ["typescript"] = true,
        -- ["php"] = true,
        -- ["ruby"] = true,
        -- ["perl"] = true,
        -- ["java"] = true,
        -- ["rust"] = true,
        -- ["tex"] = true,
        -- ["go"] = true,
        -- ["sh"] = true,
      }
    end,
    event = "InsertEnter",
  },

  {
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
  },

  {
    "luukvbaal/statuscol.nvim",
    event = "BufReadPost",
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        relculright = false,
        ft_ignore = { "neo-tree" },
        segments = {
          {
            -- line number
            text = { " ", builtin.lnumfunc },
            condition = { true, builtin.not_empty },
            click = "v:lua.ScLa",
          },
          { text = { "%s" }, click = "v:lua.ScSa" }, -- Sign
          { text = { "%C", " " }, click = "v:lua.ScFa" }, -- Fold
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
  },

  {
    "rmagatti/alternate-toggler",
    config = function()
      require("alternate-toggler").setup()
    end,
    keys = {
      { "<Space>t", "<CMD>lua require('alternate-toggler').toggleAlternate()<CR>" },
    },
  },
}
