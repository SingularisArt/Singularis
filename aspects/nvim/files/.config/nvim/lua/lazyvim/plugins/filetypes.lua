return {
  -- markdown
  {
    "mzlogin/vim-markdown-toc",
    cmd = {
      "GenTocGFM",
      "GenTocRedcarpet",
      "GenTocGitLab",
      "GenTocMarked",
    },
    ft = "markdown",
  },
  {
    "iamcco/markdown-preview.nvim",
    config = function()
      vim.g.mkdp_markdown_css = os.getenv("HOME") .. "/.config/nvim/misc/static/markdown-preview.css"
      vim.g.mkdp_highlight_css = os.getenv("HOME") .. "/.cache/wal/colors.css"
      vim.g.vim_markdown_conceal = 1
      vim.g.vim_markdown_math = 1
      vim.g.vim_markdown_conceal_code_blocks = 0
      vim.g.vim_markdown_strikethrough = 1
    end,
    cmd = "MarkdownPreviewToggle",
    ft = "markdown",
  },

  -- latex
  {
    "lervag/vimtex",
    config = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.latex_view_general_viewer = "zathura"
      vim.g.vimtex_compiler_progname = "nvr"
      vim.g.vimtex_quickfix_enabled = 0
    end,
    lazy = false,
  },
  { "KeitaNakamura/tex-conceal.vim", ft = "tex" },

  -- log
  {
    "mtdl9/vim-log-highlighting",
    ft = {
      "text",
      "txt",
      "log",
    },
  },

  -- python
  {
    "dccsillag/magma-nvim",
    config = function()
      vim.g.magma_image_provider = "ueberzug"
      vim.g.magma_automatically_open_output = false
      vim.g.magma_wrap_output = false
      vim.g.magma_output_window_borders = true
      vim.g.magma_cell_highlight_group = "CursorLine"
      vim.g.magma_save_path = vim.fn.stdpath("config") .. "/misc/magma"
    end,
    cmd = "MagmaInit",
    ft = "python",
  },

  -- rust
  {
    "simrat39/rust-tools.nvim",
    config = function()
      require("rust-tools").setup({
        server = {
          on_attach = function(c, b)
            require("navigator.lspclient.mapping").setup({ client = c, bufnr = b })
          end,
        },
      })
    end,
    ft = "rust",
  },
  {
    "Saecki/crates.nvim",
    config = function()
      require("crates").setup()
    end,
    ft = "toml",
  },

  -- java
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },

  -- go
  {
    "ray-x/go.nvim",
    ft = { "go", "gomod" },
  },

  -- C/C++
  {
    "p00f/clangd_extensions.nvim",
    config = function()
      require("clangd_extensions").setup()
    end,
    ft = {
      "c",
      "cpp",
      "objc",
      "objcpp",
      "h",
      "hpp",
    },
  },

  -- html
  { "Valloric/MatchTagAlways", ft = "html" },
  { "turbio/bracey.vim", ft = "html" },
  { "mattn/emmet-vim", ft = "html" },

  -- neorg
  {
    "nvim-neorg/neorg",
    config = function()
      -- local neorg_callbacks = require("neorg.callbacks")
      local neorg = require("neorg")

      neorg.setup({
        load = {
          ["core.defaults"] = {}, -- Load all the default modules
          ["core.export"] = {},
          ["core.norg.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          },
          ["core.looking-glass"] = {}, -- Enable the looking_glass module
          ["core.export.markdown"] = {
            config = {
              extensions = "all",
            },
          },
          -- ["external.kanban"] = {},
          -- ["external.zettelkasten"] = {},
          -- ["external.context"] = {},
          ["core.norg.concealer"] = {
            config = {
              -- markup_preset = "dimmed",
              -- markup_preset = "conceal",
              markup_preset = "varied",
              icon_preset = "diamond",
              icons = {
                marker = {
                  enabled = true,
                  icon = " ",
                },
                todo = {
                  enable = true,
                  pending = {
                    -- icon = ""
                    icon = "",
                  },
                  uncertain = {
                    icon = "?",
                  },
                  urgent = {
                    icon = "",
                  },
                  on_hold = {
                    icon = "",
                  },
                  cancelled = {
                    icon = "",
                  },
                },
                heading = {
                  enabled = true,
                  level_1 = {
                    icon = "◈",
                  },

                  level_2 = {
                    icon = " ◇",
                  },

                  level_3 = {
                    icon = "  ◆",
                  },
                  level_4 = {
                    icon = "   ❖",
                  },
                  level_5 = {
                    icon = "    ⟡",
                  },
                  level_6 = {
                    icon = "     ⋄",
                  },
                },
              },
            },
          },

          ["core.presenter"] = {
            config = {
              zen_mode = "zen-mode",
              slide_count = {
                enable = true,
                position = "top",
                count_format = "[%d/%d]",
              },
            },
          },

          ["core.norg.esupports.metagen"] = {
            config = {
              type = "auto",
            },
          },

          ["core.keybinds"] = {
            config = {
              default_keybinds = true,
              neorg_leader = "<Leader>",
            },
          },

          ["core.norg.dirman"] = { -- Manage your directories with Neorg
            config = {
              workspaces = {
                home = "~/Documents/school-notes/notes",
                personal = "~/Documents/school-notes/personal",
                college = "~/Documents/school-notes/college",
              },
              index = "index.norg",
              --[[ autodetect = true,
                  autochdir = false, ]]
            },
          },

          ["core.norg.qol.toc"] = {
            config = {
              close_split_on_jump = false,
              toc_split_placement = "left",
            },
          },

          ["core.norg.journal"] = {
            config = {
              workspace = "home",
              journal_folder = "journal",
              use_folders = false,
            },
          },
        },
      })
    end,
    dependencies = {
      { "nvim-neorg/neorg-telescope", ft = "norg" }
    },
    ft = "norg",
  },
  {
    "akinsho/org-bullets.nvim",
    config = function()
      require("org-bullets").setup()
    end,
    ft = "norg",
  },
  {
    "lukas-reineke/headlines.nvim",
    config = function()
      require("headlines").setup()
    end,
    ft = {
      "org",
      "norg",
      "markdown",
      "yaml",
    },
  },

  -- json/yaml
  { "b0o/SchemaStore.nvim", ft = { "json", "yaml" } },
}
