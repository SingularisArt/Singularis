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
    {
      "lewis6991/impatient.nvim",
      config = function()
        require("impatient")
      end,
    },

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
    -- "b0o/SchemaStore.nvim",
    "nanotee/sqls.nvim",
    {
      url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      config = function()
        require("lsp_lines").setup()
        require("lsp_lines").toggle()
      end
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
      event = "VeryLazy",
      config = function()
        require("SingularisArt.config.navigator")
      end,
    },
    {
      "folke/neoconf.nvim",
      config = function()
        require("neoconf").setup()
      end,
    },
    {
      "folke/neodev.nvim",
      event = "VeryLazy",
      config = function()
        require("neodev").setup()
      end,
    },
    {
      "j-hui/fidget.nvim",
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
      event = "InsertEnter",
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
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-calc",
        "hrsh7th/cmp-emoji",
        "hrsh7th/cmp-nvim-lua",
        "amarakon/nvim-cmp-buffer-lines",
        "andersevenrud/cmp-tmux",
        "hrsh7th/cmp-cmdline",
        "petertriho/cmp-git",
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
      -- event = "InsertEnter",
      config = function()
        require("SingularisArt.config.which-key")
      end,
    },

    ---------------------
    --  Notifications  --
    ---------------------

    {
      "rcarriga/nvim-notify",
      event = "VeryLazy",
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

    "nvim-tree/nvim-web-devicons",
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
      event = "VeryLazy",
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
      event = "VeryLazy",
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
      event = "BufWinEnter",
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
      },
      config = function()
        vim.cmd("colorscheme tokyonight-night")
      end,
    },

    ------------------
    --  Animations  --
    ------------------

    {
      "folke/noice.nvim",
      dependencies = {
        "MunifTanjim/nui.nvim",
      },
      config = function()
        require("noice").setup({
          lsp = {
            hover = { enabled = false },
            signature = { enabled = false }
          },
        })
      end,
    },

    -----------------
    --  Telescope  --
    -----------------

    {
      "nvim-telescope/telescope.nvim",
      event = "VeryLazy",
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
          end
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
    { "tpope/vim-fugitive", event = "VeryLazy" },
    { "tpope/vim-rhubarb", event = "VeryLazy" },
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
      event = "VeryLazy",
      config = function()
        local codewindow = require("codewindow")
        codewindow.setup()
      end,
    },
    {
      "akinsho/git-conflict.nvim",
      event = "VeryLazy",
      config = function()
        require("git-conflict").setup()
      end,
    },
    {
      "lewis6991/gitsigns.nvim",
      event = "VeryLazy",
      config = function()
        require("SingularisArt.config.gitsigns")
      end,
    },

    ------------------
    --  Bufferline  --
    ------------------

    -- TODO: DO THIS!
    {
      "akinsho/bufferline.nvim",
      config = function()
        require("SingularisArt.config.bufferline")
      end,
    },

    -----------------
    --  Filetypes  --
    -----------------

    { "kdheepak/cmp-latex-symbols", ft = "tex" },
    { "KeitaNakamura/tex-conceal.vim", ft = "tex" },
    {
      "lervag/vimtex",
      event = "VeryLazy",
      config = function()
        require("SingularisArt.config.vimtex")
      end,
    },

    { "mzlogin/vim-markdown-toc", ft = "markdown" },
    { "dhruvasagar/vim-table-mode", ft = "markdown" },
    {
      "iamcco/markdown-preview.nvim",
      event = "VeryLazy",
      ft = "markdown",
      config = function()
        require("SingularisArt.config.markdown-preview")
      end,
    },

    {
      "dccsillag/magma-nvim",
      -- ft = "python"
      config = function()
        require("SingularisArt.config.magma")
      end,
    },
    { "AckslD/swenv.nvim", ft = "python" },

    { "simrat39/rust-tools.nvim", ft = "rust" },
    { "Saecki/crates.nvim", ft = "rust" },

    { "mfussenegger/nvim-jdtls", ft = "java" },

    { "Valloric/MatchTagAlways", ft = "html" },
    { "turbio/bracey.vim", ft = "html" },
    { "mattn/emmet-vim", ft = "html" },
    -- TODO: DO THIS!
    { "ray-x/go.nvim", ft = "go" },

    { "MTDL9/vim-log-highlighting", ft = "log" },

    {
      "p00f/clangd_extensions.nvim",
      event = "VeryLazy",
      ft = { "c", "cpp" },
      config = function()
        require("SingularisArt.config.clangd-extensions")
      end,
    },

    {
      "nvim-neorg/neorg",
      event = "VeryLazy",
      ft = "norg",
      config = function()
        require("neorg").setup()
      end,
    },

    -------------
    --  Other  --
    -------------

    {
      "dstein64/nvim-scrollview",
      event = { "CursorMoved", "CursorMovedI" },
      config = function()
        require("SingularisArt.config.scrollview")
      end
    },
    -- {
    --   "levouh/tint.nvim",
    --   event = "VeryLazy",
    --   config = function()
    --     require("SingularisArt.config.tint")
    --   end
    -- },
    { "andymass/vim-matchup", event = "VeryLazy" },
    { "moll/vim-bbye", event = "VeryLazy" },
    { "junegunn/vim-slash", event = "VeryLazy" },
    { "kylechui/nvim-surround", event = "VeryLazy" },
    { "abecodes/tabout.nvim", event = "VeryLazy" },
    { "ThePrimeagen/harpoon", event = "VeryLazy" },
    { "mattn/webapi-vim", event = "VeryLazy" },
    { "AndrewRadev/splitjoin.vim", keymaps = { "gS", "gJ" } },
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
      event = "VeryLazy",
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
      event = "InsertEnter",
      dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
      },
      config = function()
        require("SingularisArt.config.comment")
      end,
    },
    {
      "folke/todo-comments.nvim",
      event = "VeryLazy",
      config = function()
        require("SingularisArt.config.todo-comments")
      end,
    },
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
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
    { "machakann/vim-highlightedyank", event = "VeryLazy" },
    { "wakatime/vim-wakatime", event = "VeryLazy" },
    {
      "kevinhwang91/nvim-bqf",
      event = "VeryLazy",
      config = function()
        require("SingularisArt.config.bqf")
      end,
    },
    { "nvim-pack/nvim-spectre", event = "VeryLazy" },
    {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("SingularisArt.config.indent-blankline")
      end,
    },
    { "monaqa/dial.nvim", event = "VeryLazy" },
    {
      "phaazon/hop.nvim",
      cmd = "HopWord",
      config = function()
        require("hop").setup()
      end
    },
    { "TimUntersberger/neogit", cmd = "Neogit" },
    {
      -- TODO: DO THIS!
      "nvim-neotest/neotest",
      event = "VeryLazy",
      dependencies = {
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/neotest-python",
        "nvim-neotest/neotest-vim-test",
        "haydenmeade/neotest-jest",
      },
      config = function()
        require("SingularisArt.config.neotest")
      end
    },
    {
      -- TODO: DO THIS!
      "bennypowers/nvim-regexplainer",
      event = "VeryLazy",
      config = function()
        require("regexplainer").setup()
      end,
    },
    {
      -- TODO: DO THIS!
      "kylechui/nvim-surround",
      event = "VeryLazy",
      config = function()
        require("nvim-surround").setup()
      end,
    },
    {
      "kevinhwang91/nvim-ufo",
      dependencies = {
        "kevinhwang91/promise-async",
      },
      config = function()
        require("ufo").setup()
      end,
    },
    {
      "lukas-reineke/virt-column.nvim",
      event = "VeryLazy",
      config = function()
        require("virt-column").setup()
      end,
    },
  }

  require("lazy").setup(plugins.plugins)
end

return plugins
