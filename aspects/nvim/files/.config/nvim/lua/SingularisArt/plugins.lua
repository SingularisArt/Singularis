local M = {}

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
---@diagnostic disable-next-line: missing-parameter
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  -- snapshot = "july-24",
  snapshot_path = fn.stdpath("config") .. "/snapshots",
  max_jobs = 50,
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
    prompt_border = "rounded",
  },
})

M.load = function()
  return packer.startup(function(use)
    use({ "wbthomason/packer.nvim" })

    use({ "nvim-lua/popup.nvim" })
    use({ "nvim-lua/plenary.nvim" })

    -- LSP
    use({ "neovim/nvim-lspconfig" })
    use({ "RRethy/vim-illuminate" })
    use({ "simrat39/symbols-outline.nvim" })
    use({ "ray-x/lsp_signature.nvim" })
    use({ "williamboman/mason.nvim" })
    use({ "jose-elias-alvarez/null-ls.nvim" })
    use({ "williamboman/mason-lspconfig.nvim" })
    use({ "WhoIsSethDaniel/mason-tool-installer.nvim" })
    use({ "b0o/SchemaStore.nvim" })
    use({ "nanotee/sqls.nvim" })
    use({ "lvimuser/lsp-inlayhints.nvim" })

    -- Colors
    use({
      "NvChad/nvim-colorizer.lua",
      config = function()
        require("SingularisArt.config.colorizer").setup()
      end,
    })

    -- Colorschemes
    use({ "wincent/base16-nvim" })
    use({ "wincent/pinnacle" })

    -- Indent Blankline
    use({
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("SingularisArt.config.indent-blankline").setup()
      end,
    })

    -- Utilities
    use({
      "danymat/neogen",
      config = function()
        require("SingularisArt.config.neogen").setup()
      end,
    })

    -- Git
    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("SingularisArt.config.gitsigns").setup()
      end,
    })
    use({ "tpope/vim-rhubarb" })
    use({ "tpope/vim-fugitive" })

    -- Keybindings
    use({
      "max397574/which-key.nvim",
      config = function()
        require("SingularisArt.config.which-key").setup()
      end,
      event = "BufWinEnter",
    })

    -- Comments
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("SingularisArt.config.comment").setup()
      end,
    })
    use({
      "folke/todo-comments.nvim",
      config = function()
        require("SingularisArt.config.todo-comments").setup()
      end,
    })

    -- Editing Support
    use({
      "windwp/nvim-autopairs",
      config = function()
        require("SingularisArt.config.autopairs").setup()
      end,
    })
    use({ "Valloric/MatchTagAlways" })
    use({ "wakatime/vim-wakatime" })
    use({ "dhruvasagar/vim-table-mode" })
    use({ "machakann/vim-highlightedyank" })
    use({
      "wincent/corpus",
      config = function()
        CorpusDirectories = {
          ["~/Documents/Website/content/posts"] = {
            autocommit = true,
            autoreference = 0,
            autotitle = 0,
            base = "~/Documents/Website/",
            repo = "~/Documents/Website",
            transform = "web",
          },
        }
      end,
    })

    -- TreeSitter
    use({
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require("SingularisArt.config.treesitter").setup()
      end,
    })
    use({ "JoosepAlviste/nvim-ts-context-commentstring" })
    use({ "nvim-treesitter/playground" })

    -- Run Code
    use({
      "michaelb/sniprun",
      run = "bash install.sh",
      config = function()
        require("SingularisArt.config.snip-run").setup()
      end,
    })

    -- Debugging
    use({
      "mfussenegger/nvim-dap",
      config = function()
        require("SingularisArt.config.dap").setup()
      end,
    })
    use({ "rcarriga/nvim-dap-ui" })
    use({ "theHamsta/nvim-dap-virtual-text" })
    use({ "ravenxrz/DAPInstall.nvim" })

    -- Snippets
    use({
      "SirVer/UltiSnips",
      config = function()
        vim.g.UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
        vim.g.UltiSnipsJumpForwardTrigger = "<Plug>(ultisnips_jump_forward)"
        vim.g.UltiSnipsJumpBackwardTrigger = "<Plug>(ultisnips_jump_backward)"
        vim.g.UltiSnipsListSnippets = "<c-x><c-s>"
        vim.g.UltiSnipsRemoveSelectModeMappings = 0
        vim.g.UltiSnipsEditSplit = "tabdo"
        vim.g.UltiSnipsSnippetDirectories = {
          os.getenv("HOME") .. "/.config/nvim/UltiSnips",
          "UltiSnips",
        }
      end,
    })

    -- Telescope
    use({
      "nvim-telescope/telescope.nvim",
      config = function()
        require("SingularisArt.config.telescope").setup()
      end,
    })
    use({
      "ahmedkhalf/project.nvim",
      config = function()
        require("SingularisArt.config.project").setup()
      end,
    })

    -- Completion
    use({
      "hrsh7th/nvim-cmp",
      config = function()
        require("SingularisArt.config.cmp").setup()
      end,
    })
    use({ "hrsh7th/cmp-buffer" })
    use({ "hrsh7th/cmp-path" })
    use({ "hrsh7th/cmp-nvim-lsp" })
    use({ "hrsh7th/cmp-calc" })
    use({ "hrsh7th/cmp-cmdline" })
    use({ "quangnguyen30192/cmp-nvim-ultisnips" })
    use({ "hrsh7th/cmp-emoji" })
    use({
      "petertriho/cmp-git",
      config = function()
        require("cmp_git").setup()
      end,
    })
    use({
      "hrsh7th/cmp-nvim-lua",
      ft = { "lua" },
    })
    use({
      "kdheepak/cmp-latex-symbols",
      ft = { "tex" },
    })

    -- File Browsers
    use({
      "justinmk/vim-dirvish",
      config = function()
        require("SingularisArt.config.dirvish").setup()
      end,
    })

    -- LaTeX
    use({
      "lervag/vimtex",
      config = function()
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_quickfix_enabled = 0
      end,
      ft = { "tex" },
    })
    use({
      "KeitaNakamura/tex-conceal.vim",
      ft = { "tex" },
    })

    -- Markdown
    use({
      "iamcco/markdown-preview.nvim",
      config = function()
        vim.g.mkdp_markdown_css = os.getenv("HOME") .. "/.config/nvim/static/markdown-preview/customStyle.css"
        vim.g.mkdp_highlight_css = os.getenv("HOME") .. "/.cache/wal/colors.css"
        vim.g.vim_markdown_conceal = 1
        vim.g.vim_markdown_math = 1
        vim.g.vim_markdown_conceal_code_blocks = 0
        vim.g.vim_markdown_strikethrough = 1
      end,
      run = "call mkdp#util#install()",
      ft = { "markdown" },
    })
    use({
      "mzlogin/vim-markdown-toc",
      ft = { "markdown" },
    })

    -- Neorg
    use({
      "nvim-neorg/neorg",
      config = function()
        require("SingularisArt.config.norg").setup()
      end,
    })
    use({ "folke/zen-mode.nvim" })
    use({ "nvim-neorg/neorg-telescope" })

    -- UndoTree
    use({ "mbbill/undotree" })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
      packer.sync()
    end
  end)
end

return M
