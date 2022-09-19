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

    -- Colors
    use({
      "NvChad/nvim-colorizer.lua",
      config = function()
        require("SingularisArt.config.colorizer").setup()
      end,
    })

    -- Colorschemes
    use({ "folke/tokyonight.nvim" })
    use({ "chriskempson/base16-vim" })
    use({ "flazz/vim-colorschemes" })
    use({ "wincent/pinnacle" })

    -- Indent Blankline
    use({
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("SingularisArt.config.indent-blankline").setup()
      end,
    })

    -- LSP
    use({ "neovim/nvim-lspconfig" })
    use({ "folke/lua-dev.nvim" })
    use({ "tamago324/nlsp-settings.nvim" })
    use({ "jose-elias-alvarez/null-ls.nvim" })
    use({ "RRethy/vim-illuminate" })
    use({ "simrat39/symbols-outline.nvim" })
    use({ "ray-x/lsp_signature.nvim" })
    use({ "williamboman/mason-lspconfig.nvim" })
    use({ "WhoIsSethDaniel/mason-tool-installer.nvim" })
    use({ "williamboman/mason.nvim" })
    use({ "jayp0521/mason-null-ls.nvim" })
    use({ "b0o/SchemaStore.nvim" })
    use({ "nanotee/sqls.nvim" })
    use({
      "lvimuser/lsp-inlayhints.nvim",
      config = function()
        require("SingularisArt.config.inlay-hints").setup()
      end,
    })

    -- Java
    use("mfussenegger/nvim-jdtls")

    -- Rust
    use({
      "christianchiarulli/rust-tools.nvim",
      branch = "modularize_and_inlay_rewrite",
    })

    -- Hugo
    use({ "phelipetls/vim-hugo" })

    -- Utilities
    use({
      "lewis6991/impatient.nvim",
      config = function()
        require("impatient").enable_profile()
      end,
    })
    use({
      "danymat/neogen",
      config = function()
        require("SingularisArt.config.neogen").setup()
      end,
    })
    use({ "Djancyp/regex.nvim" })

    -- Git
    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("SingularisArt.config.gitsigns").setup()
      end,
    })
    use({ "tpope/vim-rhubarb" })
    use({ "tpope/vim-fugitive" })

    -- Terminal
    use({
      "akinsho/toggleterm.nvim",
      config = function()
        require("SingularisArt.config.toggleterm").setup()
      end,
    })

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

    -- Icons
    use({ "kyazdani42/nvim-web-devicons" })

    -- TreeSitter
    use({
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require("SingularisArt.config.treesitter").setup()
      end,
    })
    use({
      "JoosepAlviste/nvim-ts-context-commentstring",
      requires = { "nvim-treesitter/nvim-treesitter", }
    })
    use({ "nvim-treesitter/playground" })
    use({ "p00f/nvim-ts-rainbow" })

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
        vim.cmd([[
          " make YCM compatible with UltiSnips (using supertab)
          let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
          let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
          let g:SuperTabDefaultCompletionType = '<C-n>'

          " better key bindings for UltiSnipsExpandTrigger
          let g:UltiSnipsJumpForwardTrigger = "<C-j>"
          let g:UltiSnipsJumpBackwardTrigger = "<C-k>"

          let g:g:UltiSnipsExpandTrigger = "<tab>"

          " open the file in a new tab
          let g:UltiSnipsEditSplit='tabdo'

          " the location of the snippets
          let g:UltiSnipsSnippetDirectories=[$HOME."/.config/nvim/UltiSnips", "UltiSnips"]
          ]])
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
    use({
      "tom-anders/telescope-vim-bookmarks.nvim",
      config = function()
        require("SingularisArt.config.bookmark").setup()
      end,
    })
    use({ "nvim-telescope/telescope-media-files.nvim" })

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
    use({ "hrsh7th/cmp-nvim-lua" })
    use({ "hrsh7th/cmp-calc" })
    use({ "quangnguyen30192/cmp-nvim-ultisnips" })
    use({ "hrsh7th/cmp-emoji" })
    use({ "kdheepak/cmp-latex-symbols" })

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
        vim.cmd([[
          let g:vimtex_view_method = 'zathura'
          let g:vimtex_quickfix_enabled=0
          ]])
      end,
    })
    use({ "KeitaNakamura/tex-conceal.vim" })

    -- Markdown
    use({
      "iamcco/markdown-preview.nvim",
      config = function()
        vim.cmd([[
          " Contains CSS for markdown + page + higlight
          let g:mkdp_markdown_css = '/home/singularis/.config/nvim/static/markdown-preview/customStyle.css'
          " Trick plugin into hosting colors.css so we get nice themes
          let g:mkdp_highlight_css = '/home/singularis/.cache/wal/colors.css'

          let g:vim_markdown_conceal = 1
          let g:vim_markdown_math = 1
          let g:vim_markdown_conceal_code_blocks = 0
          let g:vim_markdown_strikethrough = 1
          ]])
      end,
      run = "call mkdp#util#install()",
    })
    use({ "mzlogin/vim-markdown-toc" })

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
