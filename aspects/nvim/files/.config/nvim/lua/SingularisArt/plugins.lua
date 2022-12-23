local plugins = {}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

plugins.load = function()
  plugins.plugins = {
    { "nvim-lua/plenary.nvim", lazy = true },
    {
      "lewis6991/impatient.nvim",
      config = function()
        require("impatient")
      end,
    },
    {
      "nathom/filetype.nvim",
      config = function()
        vim.g.did_load_filetypes = 1
      end,
    },

    -----------
    --  LSP  --
    -----------

    { "neovim/nvim-lspconfig", lazy = true },
    { "lvimuser/lsp-inlayhints.nvim", lazy = true },
    { "ray-x/lsp_signature.nvim", lazy = true },
    { "ray-x/guihua.lua", lazy = true },
    { "b0o/SchemaStore.nvim", lazy = true },
    { "nanotee/sqls.nvim", lazy = true },
    {
      "jose-elias-alvarez/null-ls.nvim",
      lazy = true,
      config = function()
        require("SingularisArt.config.null_ls")
      end,
    },
    {
      "glepnir/lspsaga.nvim",
      lazy = true,
      config = function()
        require("lspsaga").init_lsp_saga({
          symbol_in_winbar = {
            enable = true,
          },
        })
      end,
    },
    {
      url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      lazy = true,
      config = function()
        require("lsp_lines").setup()
        require("lsp_lines").toggle()
      end,
    },
    {
      "ray-x/sad.nvim",
      cmd = "Sad",
      config = function()
        require("sad").setup()
      end,
    },
    {
      "ray-x/navigator.lua",
      lazy = true,
      config = function()
        require("SingularisArt.lsp").load()
      end,
    },
    {
      "folke/neoconf.nvim",
      lazy = true,
      config = function()
        require("neoconf").setup()
      end,
    },
    {
      "folke/neodev.nvim",
      lazy = true,
      config = function()
        require("neodev").setup()
      end,
    },
    {
      "j-hui/fidget.nvim",
      lazy = true,
      config = function()
        require("SingularisArt.config.fidget")
      end,
    },
    {
      "simrat39/symbols-outline.nvim",
      cmd = "SymbolsOutlineToggle",
      config = function()
        require("SingularisArt.config.symbols-outline")
      end,
    },
    {
      "folke/trouble.nvim",
      cmd = "Trouble",
      config = function()
        require("SingularisArt.config.trouble")
      end,
    },
    {
      "RRethy/vim-illuminate",
      lazy = true,
      config = function()
        require("SingularisArt.config.illuminate")
      end,
    },

    -------------------------
    --  Completion Engine  --
    -------------------------

    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-calc",
        "hrsh7th/cmp-emoji",
        {
          "tzachar/cmp-tabnine",
          run = "./install.sh",
          config = function()
            require("SingularisArt.config.tabnine")
          end,
        },
      },
      config = function()
        require("SingularisArt.config.cmp")
      end,
    },

    ----------------
    --  Snippets  --
    ----------------

    {
      "SirVer/ultisnips",
      event = "InsertEnter",
      config = function()
        require("SingularisArt.config.ultisnips")
      end,
    },

    ----------------
    --  Mappings  --
    ----------------

    {
      "folke/which-key.nvim",
      config = function()
        require("SingularisArt.config.which-key")
      end,
    },

    ---------------------
    --  Notifications  --
    ---------------------

    {
      "rcarriga/nvim-notify",
      lazy = true,
      config = function()
        require("SingularisArt.config.notify")
      end,
    },

    -------------
    --  Notes  --
    -------------

    {
      "wincent/corpus",
      cmd = "Corpus",
      config = function()
        CorpusDirectories = {
          ["~/Documents/Website/content/posts"] = {
            autocommit = true,
            autoreference = 0,
            autotitle = 0,
            base = "~/Documents/Website/",
            repo = "~/Documents/Website/",
            transform = "web",
          },
        }
      end,
    },

    ---------------------
    --  File Browsing  --
    ---------------------

    { "nvim-tree/nvim-web-devicons", lazy = true },
    {
      "nvim-tree/nvim-tree.lua",
      cmd = "NvimTreeToggle",
      config = function()
        require("SingularisArt.config.nvim-tree")
      end,
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      cmd = "NeoTreeShowToggle",
      dependencies = {
        "MunifTanjim/nui.nvim",
      },
    },
    {
      "tamago324/lir.nvim",
      lazy = true,
      config = function()
        require("SingularisArt.config.lir")
      end,
    },

    ---------------------
    --  Documentation  --
    ---------------------

    {
      "danymat/neogen",
      cmd = "Neogen",
      config = function()
        require("SingularisArt.config.neogen")
      end,
    },

    -----------------
    --  Debugging  --
    -----------------

    {
      "mfussenegger/nvim-dap",
      lazy = true,
      dependencies = {
        "ravenxrz/DAPInstall.nvim",
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "mfussenegger/nvim-dap-python",
      },
      config = function()
        require("SingularisArt.config.dap")
      end,
    },

    --------------------
    --  Colorschemes  --
    --------------------

    {
      "ray-x/starry.nvim",
      dependencies = {
        "lambdalisue/glyph-palette.vim",
        "wincent/base16-nvim",
        "catppuccin/vim",
        "LunarVim/onedarker.nvim",
        "martinsione/darkplus.nvim",
        "flazz/vim-colorschemes",
        "LunarVim/synthwave84.nvim",
        "folke/tokyonight.nvim",
        "catppuccin/vim",
        "ray-x/aurora",
        "projekt0n/github-nvim-theme",
        "glepnir/zephyr-nvim",
      },
      config = function()
        vim.cmd("colorscheme tokyonight-night")
      end,
    },

    ------------------
    --  Animations  --
    ------------------

    -- {
    --   "folke/noice.nvim",
    --   dependencies = {
    --     "MunifTanjim/nui.nvim",
    --   },
    --   config = function()
    --     require("noice").setup({
    --       lsp = {
    --         hover = { enabled = false },
    --         signature = { enabled = false }
    --       },
    --     })
    --   end,
    -- },

    -----------------
    --  Telescope  --
    -----------------

    {
      "nvim-telescope/telescope.nvim",
      lazy = true,
      dependencies = {
        "nvim-neorg/neorg-telescope",
      },
      config = function()
        require("SingularisArt.config.telescope")
      end,
    },

    ------------------
    --  Treesitter  --
    ------------------

    {
      "nvim-treesitter/nvim-treesitter",
      lazy = true,
      dependencies = {
        "nvim-treesitter/playground",
        "RRethy/nvim-treesitter-textsubjects",
        "p00f/nvim-ts-rainbow",
        {
          "nvim-treesitter/nvim-treesitter-context",
          config = function()
            require("treesitter-context").setup()
          end,
        },
        {
          "m-demare/hlargs.nvim",
          config = function()
            require("hlargs").setup()
          end,
        },
      },
      config = function()
        require("SingularisArt.config.treesitter")
      end,
    },

    ------------
    --  Git  --
    ------------

    { "sindrets/diffview.nvim", cmd = "DiffviewOpen" },
    { "AndrewRadev/linediff.vim", cmd = "Linediff" },
    { "tpope/vim-fugitive", lazy = true },
    { "tpope/vim-rhubarb", lazy = true },
    { "ray-x/forgit.nvim", lazy = true },
    {
      -- TODO: DO THIS!
      "pwntester/octo.nvim",
      cmd = "Octo",
      config = function()
        require("SingularisArt.config.octo")
      end,
    },
    {
      -- TODO: DO THIS!
      "mattn/vim-gist",
      cmd = "Gist",
      config = function()
        require("SingularisArt.config.gist")
      end,
    },
    {
      "gorbit99/codewindow.nvim",
      lazy = true,
      config = function()
        require("codewindow").setup()
      end,
    },
    {
      "akinsho/git-conflict.nvim",
      lazy = true,
      config = function()
        require("git-conflict").setup()
      end,
    },
    {
      "lewis6991/gitsigns.nvim",
      lazy = true,
      config = function()
        require("SingularisArt.config.gitsigns")
      end,
    },

    -----------------
    --  Filetypes  --
    -----------------

    { "kdheepak/cmp-latex-symbols", ft = "tex" },
    {
      "KeitaNakamura/tex-conceal.vim",
      ft = "tex",
      lazy = true,
    },
    {
      "lervag/vimtex",
      lazy = true,
      config = function()
        require("SingularisArt.config.vimtex")
      end,
    },

    {
      "mzlogin/vim-markdown-toc",
      ft = "markdown",
      lazy = true,
    },
    {
      "dhruvasagar/vim-table-mode",
      ft = "markdown",
      lazy = true,
    },
    {
      "iamcco/markdown-preview.nvim",
      ft = "markdown",
      lazy = true,
      config = function()
        require("SingularisArt.config.markdown-preview")
      end,
    },

    {
      "dccsillag/magma-nvim",
      lazy = true,
      ft = "python",
      config = function()
        require("SingularisArt.config.magma")
      end,
    },
    {
      "AckslD/swenv.nvim",
      ft = "python",
      lazy = true,
    },

    {
      "simrat39/rust-tools.nvim",
      ft = "rust",
      lazy = true,
    },
    {
      "Saecki/crates.nvim",
      ft = "rust",
      lazy = true,
    },

    {
      "mfussenegger/nvim-jdtls",
      ft = "java",
      lazy = true,
    },

    {
      "Valloric/MatchTagAlways",
      ft = "html",
      lazy = true,
    },
    {
      "turbio/bracey.vim",
      ft = "html",
      lazy = true,
    },
    {
      "mattn/emmet-vim",
      ft = "html",
      lazy = true,
    },
    -- TODO: DO THIS!
    {
      "ray-x/go.nvim",
      ft = "go",
      lazy = true,
    },

    {
      "MTDL9/vim-log-highlighting",
      ft = "log",
      lazy = true,
    },

    {
      "p00f/clangd_extensions.nvim",
      lazy = true,
      ft = { "c", "cpp" },
      config = function()
        require("SingularisArt.config.clangd-extensions")
      end,
    },

    {
      "nvim-neorg/neorg",
      lazy = true,
      ft = "norg",
      config = function()
        require("neorg").setup()
      end,
    },

    -------------
    --  Other  --
    -------------

    { "andymass/vim-matchup", lazy = true },
    { "moll/vim-bbye", lazy = true },
    { "junegunn/vim-slash", lazy = true },
    { "kylechui/nvim-surround", lazy = true },
    { "abecodes/tabout.nvim", lazy = true },
    { "ThePrimeagen/harpoon", lazy = true },
    { "mattn/webapi-vim", lazy = true },
    { "AndrewRadev/splitjoin.vim", lazy = true },
    { "machakann/vim-highlightedyank", lazy = true },
    { "wakatime/vim-wakatime", lazy = true },
    { "nvim-pack/nvim-spectre", lazy = true },
    { "monaqa/dial.nvim", lazy = true },
    { "TimUntersberger/neogit", cmd = "Neogit" },
    { "dstein64/vim-startuptime", lazy = true },
    {
      "dstein64/nvim-scrollview",
      event = { "CursorMoved", "CursorMovedI" },
      config = function()
        require("SingularisArt.config.scrollview")
      end,
    },
    {
      "ghillb/cybu.nvim",
      config = function()
        require("SingularisArt.config.cybu")
      end,
      keys = {
        "H",
        "L",
      },
    },
    {
      "nacro90/numb.nvim",
      lazy = true,
      config = function()
        require("SingularisArt.config.numb")
      end,
    },
    {
      "folke/zen-mode.nvim",
      cmd = "ZenMode",
      config = function()
        require("SingularisArt.config.zen-mode")
      end,
    },
    {
      "folke/twilight.nvim",
      cmd = "Twilight",
      config = function()
        require("SingularisArt.config.twilight")
      end,
    },
    {
      "karb94/neoscroll.nvim",
      config = function()
        require("SingularisArt.config.neoscroll")
      end,
      keys = {
        "<C-u>",
        "<C-d>",
        "<C-e>",
        "<C-y>",
        "zz",
        "n",
        "N",
      },
    },
    {
      "numToStr/Comment.nvim",
      lazy = true,
      dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
      },
      config = function()
        require("SingularisArt.config.comment")
      end,
    },
    {
      "folke/todo-comments.nvim",
      lazy = true,
      config = function()
        require("SingularisArt.config.todo-comments")
      end,
    },
    {
      "windwp/nvim-autopairs",
      lazy = true,
      config = function()
        require("SingularisArt.config.autopairs")
      end,
    },
    {
      "mbbill/undotree",
      cmd = "UndotreeToggle",
      config = function()
        require("SingularisArt.config.undotree")
      end,
    },
    {
      "kevinhwang91/nvim-bqf",
      lazy = true,
      config = function()
        require("SingularisArt.config.bqf")
      end,
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      lazy = true,
      config = function()
        require("SingularisArt.config.indent-blankline")
      end,
    },
    {
      "phaazon/hop.nvim",
      lazy = true,
      config = function()
        require("hop").setup()
      end,
    },
    {
      -- TODO: DO THIS!
      "nvim-neotest/neotest",
      lazy = true,
      dependencies = {
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/neotest-python",
        "nvim-neotest/neotest-vim-test",
        "haydenmeade/neotest-jest",
      },
      config = function()
        require("SingularisArt.config.neotest")
      end,
    },
    {
      -- TODO: DO THIS!
      "bennypowers/nvim-regexplainer",
      lazy = true,
      config = function()
        require("regexplainer").setup()
      end,
    },
    {
      -- TODO: DO THIS!
      "kylechui/nvim-surround",
      lazy = true,
      config = function()
        require("nvim-surround").setup()
      end,
    },
    {
      "kevinhwang91/nvim-ufo",
      lazy = true,
      dependencies = {
        "kevinhwang91/promise-async",
      },
      config = function()
        require("ufo").setup()
      end,
    },
    {
      "lukas-reineke/virt-column.nvim",
      lazy = true,
      config = function()
        require("virt-column").setup()
      end,
    },
  }

  require("lazy").setup(plugins.plugins)
end

return plugins
