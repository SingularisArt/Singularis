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
    "nvim-lua/plenary.nvim",

    -----------
    --  LSP  --
    -----------

    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "jay-babu/mason-null-ls.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    "lvimuser/lsp-inlayhints.nvim",
    "ray-x/lsp_signature.nvim",
    "ray-x/guihua.lua",
    "folke/neoconf.nvim",
    "ray-x/navigator.lua",
    "b0o/SchemaStore.nvim",
    "nanotee/sqls.nvim",
    -- "VonHeikemen/lsp-zero.nvim",
    "folke/neodev.nvim",
    {
      "j-hui/fidget.nvim",
      config = function()
        require("SingularisArt.config.fidget")
      end
    },
    {
      "simrat39/symbols-outline.nvim",
      config = function()
        require("SingularisArt.config.symbols-outline")
      end,
      cmd = "SymbolsOutlineToggle",
    },
    {
      "folke/trouble.nvim",
      config = function()
        require("SingularisArt.config.trouble").setup()
      end
    },
    {
      "RRethy/vim-illuminate",
      config = function()
        require("SingularisArt.config.illuminate").setup()
      end
    },

    -------------------------
    --  Completion Engine  --
    -------------------------

    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-calc",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-emoji",
        "hrsh7th/cmp-nvim-lua",
        "amarakon/nvim-cmp-buffer-lines",
        "andersevenrud/cmp-tmux",
        "hrsh7th/cmp-cmdline",
        "petertriho/cmp-git",
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
      event = "VeryLazy",
    },

    ---------------------
    --  Notifications  --
    ---------------------

    {
      "rcarriga/nvim-notify",
      config = function()
        require("SingularisArt.config.notify")
      end,
    },

    -------------
    --  Notes  --
    -------------

    {
      "wincent/corpus",
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

    "nvim-tree/nvim-web-devicons",
    {
      "nvim-tree/nvim-tree.lua",
      config = function()
        require("SingularisArt.config.nvim-tree")
      end,
      cmd = "NvimTreeToggle",
      event = "VeryLazy",
    },
    {
      "tamago324/lir.nvim",
      config = function()
        require("SingularisArt.config.lir")
      end,
      keys = {
        "<Leader>-",
      },
    },

    ---------------------
    --  Documentation  --
    ---------------------

    {
      "danymat/neogen",
      config = function()
        require("SingularisArt.config.neogen")
      end,
      cmd = "Neogen",
    },

    -----------------
    --  Debugging  --
    -----------------

    {
      "mfussenegger/nvim-dap",
      config = function()
        require("SingularisArt.config.dap")
      end,
      dependencies = {
        "ravenxrz/DAPInstall.nvim",
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        -- "mfussenegger/nvim-dap-python",
      },
    },

    --------------------
    --  Colorschemes  --
    --------------------

    "folke/tokyonight.nvim",
    "wincent/base16-nvim",
    "catppuccin/vim",
    "LunarVim/onedarker.nvim",
    "martinsione/darkplus.nvim",
    "flazz/vim-colorschemes",
    "LunarVim/synthwave84.nvim",

    --------------
    --  Colors  --
    --------------

    "nvim-colortils/colortils.nvim",
    {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("SingularisArt.config.colorizer")
      end
    },
    "wincent/pinnacle",

    ------------------
    --  Animations  --
    ------------------

    {
      "folke/noice.nvim",
      config = function()
        require("noice").setup()
      end,
      dependencies = {
        "MunifTanjim/nui.nvim",
      },
    },

    -----------------
    --  Telescope  --
    -----------------

    {
      "nvim-telescope/telescope.nvim",
      config = function()
        require("SingularisArt.config.telescope")
      end,
      dependencies = {
        "nvim-neorg/neorg-telescope",
      },
    },

    ------------------
    --  Treesitter  --
    ------------------

    {
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require("SingularisArt.config.treesitter")
      end,
      dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
        "nvim-treesitter/playground",
        "nvim-treesitter/nvim-tree-docs",
      },
    },

    ------------
    --  Git  --
    ------------

    {
      "lewis6991/gitsigns.nvim",
      config = function()
        require("SingularisArt.config.gitsigns")
      end,
      dependencies = {
        "tpope/vim-fugitive",
        "tpope/vim-rhubarb",
        "ruifm/gitlinker.nvim",
        "pwntester/octo.nvim",
        "mattn/vim-gist",
        -- "f-person/git-blame.nvim",
      },
    },

    -----------------
    --  Filetypes  --
    -----------------

    {
      "kdheepak/cmp-latex-symbols",
      ft = "tex",
    },
    {
      "KeitaNakamura/tex-conceal.vim",
      ft = "tex",
    },
    {
      "lervag/vimtex",
      config = function()
        require("SingularisArt.config.vimtex")
      end,
    },

    {
      "iamcco/markdown-preview.nvim",
      dependencies = {
        "mzlogin/vim-markdown-toc",
        "dhruvasagar/vim-table-mode",
      },
      ft = "markdown",
      config = function()
        require("SingularisArt.config.markdown-preview")
      end,
    },

    {
      "dccsillag/magma-nvim",
      ft = "python",
    },
    {
      "AckslD/swenv.nvim",
      ft = "python",
    },

    {
      "simrat39/rust-tools.nvim",
      ft = "rust",
    },
    {
      "Saecki/crates.nvim",
      ft = "rust",
    },

    {
      "mfussenegger/nvim-jdtls",
      ft = "java",
    },

    {
      "Valloric/MatchTagAlways",
      ft = "html",
    },

    {
      "nvim-neorg/neorg",
      ft = "norg",
      config = function()
        require("neorg").setup()
      end,
    },

    -------------
    --  Other  --
    -------------

    "andymass/vim-matchup",
    "moll/vim-bbye",
    "junegunn/vim-slash",
    "kylechui/nvim-surround",
    "abecodes/tabout.nvim",
    "ThePrimeagen/harpoon",
    "mattn/webapi-vim",
    {
      "ghillb/cybu.nvim",
      config = function()
        require("SingularisArt.config.cybu")
      end,
      keys = {
        "H",
        "L",
      }
    },
    {
      "nacro90/numb.nvim",
      config = function()
        require("SingularisArt.config.numb")
      end,
      event = "VeryLazy",
    },
    {
      "folke/zen-mode.nvim",
      config = function()
        require("SingularisArt.config.zen-mode")
      end,
      cmd = "ZenMode",
    },
    {
      "folke/twilight.nvim",
      config = function()
        require("SingularisArt.config.twilight")
      end,
      cmd = "Twilight",
    },
    {
      "SmiteshP/nvim-navic",
      config = function()
        require("SingularisArt.config.navic")
        require("SingularisArt.config.winbar")
      end,
    },
    {
      "karb94/neoscroll.nvim",
      config = function()
        require("SingularisArt.config.neoscroll")
      end,
    },
    {
      "numToStr/Comment.nvim",
      config = function()
        require("SingularisArt.config.comment")
      end,
      event = "VeryLazy",
      keys = {
        "<Leader>/",
      },
    },
    {
      "folke/todo-comments.nvim",
      config = function()
        require("SingularisArt.config.todo-comments")
      end,
      event = "VeryLazy",
    },
    {
      "windwp/nvim-autopairs",
      config = function()
        require("SingularisArt.config.autopairs")
      end,
      event = "VeryLazy",
    },
    {
      "mbbill/undotree",
      config = function()
        require("SingularisArt.config.undotree")
      end,
      event = "VeryLazy",
      cmd = "UndotreeToggle",
    },
    {
      "machakann/vim-highlightedyank",
      event = "VeryLazy",
    },
    {
      "wakatime/vim-wakatime",
      event = "VeryLazy",
    },
    {
      "kevinhwang91/nvim-bqf",
      config = function()
        require("SingularisArt.config.bqf")
      end,
      event = "VeryLazy",
    },
    {
      "nvim-pack/nvim-spectre",
      event = "VeryLazy",
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("SingularisArt.config.indent-blankline")
      end,
    },
    {
      "monaqa/dial.nvim",
      event = "VeryLazy",
    },
  }

  require("lazy").setup(plugins.plugins)
end

return plugins
