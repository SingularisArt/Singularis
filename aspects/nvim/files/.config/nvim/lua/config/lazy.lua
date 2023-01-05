local utils = require("util.plugins")

local conf = utils.config
utils.bootstrap_lazy()

-- BBOX: CORE
-- "nvim-lua/plenary.nvim",
-- "kyazdani42/nvim-web-devicons",
-- "lambdalisue/glyph-palette.vim",

-- {
--   "nvim-telescope/telescope.nvim",
--   config = conf("telescope"),
--   lazy = true,
-- },

-- {
--   "ahmedkhalf/project.nvim",
--   config = function()
--     require("project_nvim").setup({
--       detection_methods = { "pattern", "lsp" },
--       ignore_lsp = { "null-ls" },
--       patterns = { ".git" },
--     })
--   end,
--   lazy = true,
-- },

-- {
--   "rmagatti/auto-session",
--   config = function()
--     local data = vim.fn.stdpath("data")
--     require("auto-session").setup({
--       log_level = "error",
--       auto_session_root_dir = data .. "/session/auto/",
--       auto_session_use_git_branch = false,
--     })
--   end,
--   lazy = true,
-- },

-- -- BBOX: LSP
-- { "neovim/nvim-lspconfig", lazy = true },
-- { "b0o/SchemaStore.nvim", lazy = true },
-- { "nanotee/sqls.nvim", lazy = true },

-- {
--   "williamboman/mason.nvim",
--   config = function()
--     require("mason").setup()
--   end,
--   dependencies = {
--     {
--       "williamboman/mason-lspconfig.nvim",
--       config = function()
--         require("mason-lspconfig").setup({
--           automatic_installation = true,
--         })
--       end
--     },
--     {
--       "jay-babu/mason-nvim-dap.nvim",
--       config = function()
--         require("mason-nvim-dap").setup({
--           automatic_installation = true,
--         })
--       end
--     },
--     {
--       "jay-babu/mason-null-ls.nvim",
--       config = function()
--         require("mason-null-ls").setup({
--           automatic_installation = true,
--         })
--       end
--     },
--   },
--   lazy = true,
-- },

-- {
--   "jose-elias-alvarez/null-ls.nvim",
--   config = conf("null-ls"),
--   lazy = true,
-- },

-- {
--   "j-hui/fidget.nvim",
--   config = function()
--     require("fidget").setup({
--       sources = {
--         ["null-ls"] = { ignore = true },
--       },
--     })
--   end,
--   lazy = true,
-- },

-- {
--   "folke/trouble.nvim",
--   cmd = {
--     "Trouble",
--     "TroubleToggle",
--   },
--   config = function()
--     require("trouble").setup()
--   end,
--   lazy = true,
-- },

-- {
--   "ray-x/go.nvim",
--   config = conf("go"),
--   ft = {
--     "go",
--     "gomod",
--   },
--   lazy = true,
-- },

-- {
--   "glepnir/lspsaga.nvim",
--   config = function()
--     require("lspsaga").init_lsp_saga({
--       border_style = "rounded",
--       code_action_lightbulb = {
--         enable = false,
--       },
--       symbol_in_winbar = {
--         enable = true,
--       },
--     })
--   end,
--   lazy = true,
-- },

-- {
--   "ray-x/navigator.lua",
--   dependencies = {
--     "ray-x/guihua.lua",
--   },
--   config = conf("navigator"),
--   lazy = true,
-- },

-- {
--   "simrat39/symbols-outline.nvim",
--   config = function()
--     require("symbols-outline").setup()
--   end,
--   cmd = {
--     "SymbolsOutline",
--     "SymbolsOutlineOpen",
--   },
--   lazy = true,
-- },

-- {
--   "kosayoda/nvim-lightbulb",
--   config = function()
--     require("nvim-lightbulb").setup({
--       autocmd = {
--         enabled = true,
--       },
--     })
--   end,
--   lazy = true,
-- },

-- {
--   "ray-x/lsp_signature.nvim",
--   config = conf("signature"),
--   lazy = true,
-- },

-- -- BBOX: Completion
-- {
--   "hrsh7th/nvim-cmp",
--   config = conf("cmp"),
--   dependencies = {
--     { "hrsh7th/cmp-buffer", after = "nvim-cmp", lazy = true },
--     { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp", lazy = true },
--     { "hrsh7th/cmp-calc", after = "nvim-cmp", lazy = true },
--     { "hrsh7th/cmp-path", after = "nvim-cmp", lazy = true },
--     { "hrsh7th/cmp-cmdline", after = "nvim-cmp", lazy = true },
--     { "hrsh7th/cmp-emoji", after = "nvim-cmp", lazy = true },
--     { "ray-x/cmp-treesitter", after = "nvim-cmp", lazy = true },
--     { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp", lazy = true },
--     { "f3fora/cmp-spell", after = "nvim-cmp", lazy = true },
--     { "octaltree/cmp-look", after = "nvim-cmp", lazy = true },
--     { "kdheepak/cmp-latex-symbols", after = "nvim-cmp", lazy = true },
--     { "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp", lazy = true },
--     {
--       "petertriho/cmp-git",
--       after = "nvim-cmp",
--       -- config = function()
--       --   local format = require("cmp_git.format")
--       --   local sort = require("cmp_git.sort")

--       --   require("cmp_git").setup({
--       --     -- defaults
--       --     filetypes = { "gitcommit", "octo" },
--       --     remotes = { "upstream", "origin" }, -- in order of most to least prioritized
--       --     enableRemoteUrlRewrites = false, -- enable git url rewrites, see https://git-scm.com/docs/git-config#Documentation/git-config.txt-urlltbasegtinsteadOf
--       --     git = {
--       --       commits = {
--       --         limit = 100,
--       --         sort_by = sort.git.commits,
--       --         format = format.git.commits,
--       --       },
--       --     },
--       --     github = {
--       --       issues = {
--       --         fields = { "title", "number", "body", "updatedAt", "state" },
--       --         filter = "all", -- assigned, created, mentioned, subscribed, all, repos
--       --         limit = 100,
--       --         state = "open", -- open, closed, all
--       --         sort_by = sort.github.issues,
--       --         format = format.github.issues,
--       --       },
--       --       mentions = {
--       --         limit = 100,
--       --         sort_by = sort.github.mentions,
--       --         format = format.github.mentions,
--       --       },
--       --       pull_requests = {
--       --         fields = { "title", "number", "body", "updatedAt", "state" },
--       --         limit = 100,
--       --         state = "open", -- open, closed, merged, all
--       --         sort_by = sort.github.pull_requests,
--       --         format = format.github.pull_requests,
--       --       },
--       --     },
--       --     gitlab = {
--       --       issues = {
--       --         limit = 100,
--       --         state = "opened", -- opened, closed, all
--       --         sort_by = sort.gitlab.issues,
--       --         format = format.gitlab.issues,
--       --       },
--       --       mentions = {
--       --         limit = 100,
--       --         sort_by = sort.gitlab.mentions,
--       --         format = format.gitlab.mentions,
--       --       },
--       --       merge_requests = {
--       --         limit = 100,
--       --         state = "opened", -- opened, closed, locked, merged
--       --         sort_by = sort.gitlab.merge_requests,
--       --         format = format.gitlab.merge_requests,
--       --       },
--       --     },
--       --     trigger_actions = {
--       --       {
--       --         debug_name = "git_commits",
--       --         trigger_character = ":",
--       --         action = function(sources, trigger_char, callback, params, _)
--       --           return sources.git:get_commits(callback, params, trigger_char)
--       --         end,
--       --       },
--       --       {
--       --         debug_name = "gitlab_issues",
--       --         trigger_character = "#",
--       --         action = function(sources, trigger_char, callback, _, git_info)
--       --           return sources.gitlab:get_issues(callback, git_info, trigger_char)
--       --         end,
--       --       },
--       --       {
--       --         debug_name = "gitlab_mentions",
--       --         trigger_character = "@",
--       --         action = function(sources, trigger_char, callback, _, git_info)
--       --           return sources.gitlab:get_mentions(callback, git_info, trigger_char)
--       --         end,
--       --       },
--       --       {
--       --         debug_name = "gitlab_mrs",
--       --         trigger_character = "!",
--       --         action = function(sources, trigger_char, callback, _, git_info)
--       --           return sources.gitlab:get_merge_requests(callback, git_info, trigger_char)
--       --         end,
--       --       },
--       --       {
--       --         debug_name = "github_issues_and_pr",
--       --         trigger_character = "#",
--       --         action = function(sources, trigger_char, callback, _, git_info)
--       --           return sources.github:get_issues_and_prs(callback, git_info, trigger_char)
--       --         end,
--       --       },
--       --       {
--       --         debug_name = "github_mentions",
--       --         trigger_character = "@",
--       --         action = function(sources, trigger_char, callback, _, git_info)
--       --           return sources.github:get_mentions(callback, git_info, trigger_char)
--       --         end,
--       --       },
--       --     },
--       --   }
--       --   )
--       -- end,
--       lazy = true,
--     },
--     { "Dosx001/cmp-commit", after = "nvim-cmp", lazy = true },
--     { "hrsh7th/cmp-cmdline", after = "nvim-cmp", lazy = true },
--     { "David-Kunz/cmp-npm", after = "nvim-cmp", lazy = true },
--     { "max397574/cmp-greek", after = "nvim-cmp", lazy = true },
--   },
--   event = "InsertEnter",
-- },

-- {
--   "SirVer/ultisnips",
--   config = function()
--     vim.cmd([[
--       let g:UltiSnipsExpandTrigger="<Tab>"
--       let g:UltiSnipsJumpForwardTrigger="<Plug>(ultisnips_jump_forward)"
--       let g:UltiSnipsJumpBackwardTrigger="<Plug>(ultisnips_jump_backward)"
--       let g:UltiSnipsListSnippets="<c-x><c-s>"
--       let g:UltiSnipsRemoveSelectModeMappings=0
--       let g:UltiSnipsEditSplit="tabdo"
--       let g:UltiSnipsSnippetDirectories=[$HOME."/.config/nvim/UltiSnips", "UltiSnips"]
--     ]])
--   end,
--   event = "InsertEnter",
-- },

-- -- BBOX: Testing and Debugging
-- {
--   "nvim-neotest/neotest",
--   config = conf("neotest"),
--   lazy = true,
-- },

-- {
--   "mfussenegger/nvim-dap",
--   config = conf("dap"),
--   dependencies = {
--     "ravenxrz/DAPInstall.nvim",
--     "rcarriga/nvim-dap-ui",
--     "theHamsta/nvim-dap-virtual-text",
--     {
--       "mfussenegger/nvim-dap-python",
--       ft = "python",
--     },
--   },
--   lazy = true,
-- },

-- -- BBOX: UI
-- {
--   "folke/which-key.nvim",
--   config = conf("which-key"),
--   lazy = true,
-- },

-- {
--   "rcarriga/nvim-notify",
--   config = conf("notify"),
--   lazy = true,
-- },

-- {
--   "akinsho/bufferline.nvim",
--   config = conf("bufferline"),
--   lazy = true,
-- },

-- {
--   "gorbit99/codewindow.nvim",
--   config = function()
--     local codewindow = require("codewindow")
--     codewindow.setup()
--     codewindow.apply_default_keybinds()
--     vim.cmd("command! -nargs=0 Minimap :lua require(\"codewindow\").toggle_minimap()")
--   end,
--   cmd = "Minimap",
--   lazy = true,
-- },

-- {
--   "lukas-reineke/indent-blankline.nvim",
--   config = conf("indentline-blankline"),
--   lazy = true,
-- },

-- {
--   "dstein64/nvim-scrollview",
--   config = conf("scrollview"),
--   event = {
--     "CursorMoved",
--     "CursorMovedI",
--   },
--   lazy = true,
-- },


-- { "wincent/pinnacle", lazy = true },

-- -- BBOX: File Browsers
-- {
--   "kyazdani42/nvim-tree.lua",
--   config = conf("nvim-tree"),
--   cmd = "NvimTreeToggle",
--   lazy = true,
-- },

-- {
--   "nvim-neo-tree/neo-tree.nvim",
--   config = conf("neo-tree"),
--   cmd = "Neotree",
--   dependencies = {
--     "MunifTanjim/nui.nvim",
--   },
--   lazy = true,
-- },

-- {
--   "tamago324/lir.nvim",
--   config = conf("lir"),
--   lazy = true,
-- },

-- {
--   "sidebar-nvim/sidebar.nvim",
--   config = conf("sidebar"),
--   cmd = {
--     "SidebarNvimToggle",
--     "SidebarNvimOpen",
--   },
--   lazy = true,
-- },

-- -- BBOX: Utilities
-- { "kamykn/spelunker.vim", lazy = true },
-- { "machakann/vim-highlightedyank", lazy = true },
-- { "wakatime/vim-wakatime", lazy = true },
-- { "nvim-pack/nvim-spectre", lazy = true },
-- { "moll/vim-bbye", lazy = true },
-- { "junegunn/vim-slash", lazy = true },
-- { "abecodes/tabout.nvim", lazy = true },

-- {
--   "kevinhwang91/nvim-bqf",
--   config = conf("bqf"),
--   lazy = true,
-- },

-- -- TODO: DO THIS!
-- {
--   "cshuaimin/ssr.nvim",
--   config = function()
--     require("ssr").setup {
--       min_width = 50,
--       min_height = 5,
--       max_width = 120,
--       max_height = 25,
--       keymaps = {
--         close = "q",
--         next_match = "n",
--         prev_match = "N",
--         replace_confirm = "<cr>",
--         replace_all = "<leader><cr>",
--       },
--     }
--   end,
--   lazy = true,
-- },

-- {
--   "folke/zen-mode.nvim",
--   config = conf("zen-mode"),
--   lazy = true,
-- },

-- {
--   "folke/twilight.nvim",
--   config = function()
--     require("twilight").setup()
--   end,
--   lazy = true,
-- },

-- {
--   "karb94/neoscroll.nvim",
--   config = conf("neoscroll"),
--   keys = {
--     "<C-u>",
--     "<C-d>",
--     "<C-e>",
--     "<C-y>",
--     "zz",
--     "n",
--     "N",
--   },
--   lazy = true,
-- },

-- {
--   "ghillb/cybu.nvim",
--   config = conf("cybu"),
--   keys = {
--     "H",
--     "L",
--   },
--   lazy = true,
-- },

-- {
--   "ziontee113/syntax-tree-surfer",
--   config = conf("tree-surfer"),
--   lazy = true,
-- },

-- {
--   "bennypowers/nvim-regexplainer",
--   config = conf("regexplainer"),
--   cmd = {
--     "RegexplainerToggle",
--     "RegexplainerShow",
--   },
--   lazy = true,
-- },

-- {
--   "danymat/neogen",
--   config = conf("neogen"),
--   cmd = "Neogen",
--   lazy = true,
-- },

-- {
--   "yardnsm/vim-import-cost",
--   cmd = "ImportCost",
--   lazy = true,
-- },

-- {
--   "mizlan/iswap.nvim",
--   config = function() require("iswap").setup() end,
--   cmd = {
--     "ISwap",
--     "ISwapWith",
--   },
--   lazy = true,
-- },

-- {
--   "mbbill/undotree",
--   config = function()
--     vim.g.undotree_TreeNodeShape = "◦"
--     vim.g.undotree_SetFocusWhenToggle = 1
--   end,
--   cmd = "UndotreeToggle",
--   lazy = true,
-- },

-- {
--   "ray-x/viewdoc.nvim",
--   config = function()
--     require("viewdoc").setup()
--   end,
--   lazy = true,
-- },

-- {
--   "nacro90/numb.nvim",
--   config = function()
--     require("numb").setup()
--   end,
--   event = "CmdlineEnter",
--   lazy = true,
-- },

-- {
--   "windwp/nvim-autopairs",
--   config = conf("autopairs"),
--   lazy = true,
-- },

-- {
--   "andymass/vim-matchup",
--   config = function()
--     vim.g.matchup_enabled = 1
--     vim.g.matchup_surround_enabled = 1
--     vim.g.matchup_transmute_enabled = 1
--     vim.g.matchup_matchparen_deferred = 1
--     vim.g.matchup_matchparen_offscreen = { method = "popup" }
--     vim.cmd([[nnoremap <c-s-k> :<c-u>MatchupWhereAmI?<cr>]])
--   end,
--   event = {
--     "CursorHold",
--     "CursorHoldI",
--   },
--   lazy = true,
-- },

-- {
--   "machakann/vim-sandwich",
--   config = function()
--     vim.cmd([[
--     nmap ca <Plug>(sandwich-add)
--    xmap ca <Plug>(sandwich-add)
--    omap ca <Plug>(sandwich-add)
--    nmap cd <Plug>(sandwich-delete)
--    xmap cd <Plug>(sandwich-delete)
--    nmap cda <Plug>(sandwich-delete-auto)
--    nmap cdb <Plug>(sandwich-delete-auto)
--    nmap cr <Plug>(sandwich-replace)
--    xmap cr <Plug>(sandwich-replace)
--    nmap crb <Plug>(sandwich-replace-auto)
--    nmap cra <Plug>(sandwich-replace-auto)
--     omap ib <Plug>(textobj-sandwich-auto-i)
--    xmap ib <Plug>(textobj-sandwich-auto-i)
--    omap ab <Plug>(textobj-sandwich-auto-a)
--    xmap ab <Plug>(textobj-sandwich-auto-a)
--    omap is <Plug>(textobj-sandwich-query-i)
--    xmap is <Plug>(textobj-sandwich-query-i)
--    omap as <Plug>(textobj-sandwich-query-a)
--    xmap as <Plug>(textobj-sandwich-query-a)
--   ]] )
--   end,
--   cmd = "Sandwith",
--   event = { "CursorMoved", "CursorMovedI" },
--   lazy = true,
--   setup = function()
--     vim.g.sandwich_no_default_key_mappings = 1
--   end,
-- },

-- {
--   "kylechui/nvim-surround",
--   config = function()
--     require("nvim-surround").setup({
--       keymaps = {
--         visual = "<Leader>cr",
--       },
--     })
--   end,
--   lazy = true,
-- },

-- {
--   "rrethy/vim-hexokinase",
--   config = conf("hexokinase"),
--   cmd = {
--     "HexokinaseTurnOn",
--     "HexokinaseToggle",
--   },
--   lazy = true,
-- },

-- {
--   "chrisbra/Colorizer",
--   cmd = {
--     "ColorHighlight",
--     "ColorUnhighlight",
--   },
--   ft = {
--     "log",
--     "txt",
--     "text",
--   },
--   lazy = true,
-- },

-- {
--   "booperlv/nvim-gomove",
--   keys = {
--     "v",
--     "V",
--     "<c-v>",
--     "<c-V>",
--   },
--   config = conf("move"),
-- },

-- {
--   "kevinhwang91/nvim-ufo",
--   config = conf("ufo"),
--   dependencies = { "kevinhwang91/promise-async" },
--   lazy = true,
-- },

-- {
--   "mg979/vim-visual-multi",
--   keys = {
--     "<Ctrl>",
--     "<M>",
--     "<C-n>",
--     "<C-n>",
--     "<M-n>",
--     "<S-Down>",
--     "<S-Up>",
--     "<M-Left>",
--     "<M-i>",
--     "<M-Right>",
--     "<M-D>",
--     "<M-Down>",
--     "<C-d>",
--     "<C-Down>",
--     "<S-Right>",
--     "<C-LeftMouse>",
--     "<M-LeftMouse>",
--     "<M-C-RightMouse>",
--     "<Leader>",
--   },
--   lazy = true,
--   setup = conf("vmulti"),
-- },

-- {
--   "phaazon/hop.nvim",
--   config = function()
--     require("hop").setup({ keys = "adghklqwertyuiopzxcvbnmfjADHKLWERTYUIOPZXCVBNMFJ1234567890" })
--   end,
--   cmd = {
--     "HopWord",
--     "HopWordMW",
--     "HopWordAC",
--     "HopWordBC",
--     "HopLine",
--     "HopChar1",
--     "HopChar1MW",
--     "HopChar1AC",
--     "HopChar1BC",
--     "HopChar2",
--     "HopChar2MW",
--     "HopChar2AC",
--     "HopChar2BC",
--     "HopPattern",
--     "HopPatternAC",
--     "HopPatternBC",
--     "HopChar1CurrentLineAC",
--     "HopChar1CurrentLineBC",
--     "HopChar1CurrentLine",
--   },
-- },

-- {
--   "indianboy42/hop-extensions",
--   after = "hop.nvim",
--   lazy = true,
-- },

-- {
--   "folke/todo-comments.nvim",
--   config = conf("todo-comments"),
--   lazy = true,
-- },

-- {
--   "numToStr/Comment.nvim",
--   config = conf("comment"),
--   keys = {
--     "g",
--     "<ESC>",
--     "v",
--     "V",
--     "<c-v>",
--   },
--   lazy = true,
-- },

-- {
--   "dhruvasagar/vim-table-mode",
--   cmd = "TableModeToggle",
--   lazy = true,
-- },

-- {
--   "simnalamburt/vim-mundo",
--   cmd = {
--     "MundoToggle",
--     "MundoShow",
--     "MundoHide",
--   },
--   lazy = true,
--   run = function()
--     vim.cmd([[packadd vim-mundo]])
--     vim.cmd([[UpdateRemotePlugins]])
--   end,
--   setup = function()
--     vim.g.mundo_prefer_python3 = 1
--   end,
-- },

-- {
--   "AndrewRadev/splitjoin.vim",
--   cmd = {
--     "SplitjoinJoin",
--     "SplitjoinSplit",
--   },
--   lazy = true,
--   setup = function()
--     vim.g.splitjoin_split_mapping = ""
--     vim.g.splitjoin_join_mapping = ""
--   end,
-- },

-- {
--   "Pocco81/true-zen.nvim",
--   config = function()
--     require("true-zen").setup()
--   end,
--   cmd = {
--     "TZAtaraxis",
--     "TZMinimalist",
--     "TZNarrow",
--     "TZFocus",
--   },
--   lazy = true,
-- },

-- {
--   "wellle/targets.vim",
--   event = {
--     "CursorHold",
--     "CursorHoldI",
--     "CursorMoved",
--     "CursorMovedI",
--   },
--   lazy = true,
--   setup = function() end,
-- },

-- {
--   "AndrewRadev/switch.vim",
--   cmd = {
--     "Switch",
--     "SwitchCase",
--   },
--   keys = "<Plug>(Switch)",
--   lazy = true,
--   setup = function()
--     vim.g.switch_mapping = "<Space>t"
--   end,
-- },

-- -- BBOX: Profiling and Startup
-- {
--   "dstein64/vim-startuptime",
--   config = function()
--     vim.g.startuptime_tries = 15
--     vim.g.startuptime_exe_args = { "+let g:auto_session_enabled = 0" }
--   end,
--   cmd = "StartupTime",
--   lazy = true,
-- },

-- -- BBOX: Tpope
-- {
--   "kristijanhusak/vim-dadbod-ui",
--   dependencies = "tpope/vim-dadbod",
--   cmd = {
--     "DBUI",
--     "DBUIToggle",
--     "DBUIAddConnection",
--   },
--   setup = function()
--     vim.g.db_ui_use_nerd_fonts = 1
--     vim.g.db_ui_show_database_icon = 1
--     -- as.nnoremap("<leader>db", "<cmd>DBUIToggle<CR>", "dadbod: toggle")
--   end,
--   lazy = true,
-- },

-- -- BBOX: Syntax
-- {
--   "nvim-treesitter/nvim-treesitter",
--   config = conf("treesitter"),
--   dependencies = {
--     "nvim-treesitter/nvim-treesitter-textobjects",
--     "RRethy/nvim-treesitter-textsubjects",
--     "nvim-treesitter/nvim-treesitter-refactor",
--     "JoosepAlviste/nvim-ts-context-commentstring",
--     "windwp/nvim-ts-autotag",
--     "nvim-treesitter/nvim-treesitter-context",
--     "p00f/nvim-ts-rainbow",
--     {
--       "nvim-treesitter/playground",
--       cmd = {
--         "TSPlaygroundToggle",
--         "TSHighlightCapturesUnderCursor",
--       },
--     },
--   },
--   lazy = true,
-- },

-- {
--   "m-demare/hlargs.nvim",
--   config = function()
--     require("hlargs").setup()
--   end,
--   lazy = true,
-- },

-- -- BBOX: Filetype
-- {
--   "KeitaNakamura/tex-conceal.vim",
--   ft = "tex",
--   lazy = true,
-- },
-- {
--   "lervag/vimtex",
--   config = function()
--   end,
--   lazy = true,
-- },

-- {
--   "mzlogin/vim-markdown-toc",
--   ft = "markdown",
--   lazy = true,
-- },
-- {
--   "dhruvasagar/vim-table-mode",
--   ft = "markdown",
--   lazy = true,
-- },
-- {
--   "iamcco/markdown-preview.nvim",
--   config = conf("markdown-preview"),
--   ft = "markdown",
--   lazy = true,
-- },

-- {
--   "mtdl9/vim-log-highlighting",
--   ft = {
--     "text",
--     "txt",
--     "log",
--   },
--   lazy = true,
-- },

-- {
--   "dccsillag/magma-nvim",
--   config = conf("magma"),
--   ft = "python",
--   lazy = true,
-- },
-- {
--   "AckslD/swenv.nvim",
--   ft = "python",
--   lazy = true,
-- },

-- {
--   "simrat39/rust-tools.nvim",
--   config = function()
--     require("rust-tools").setup({
--       server = {
--         on_attach = function(c, b)
--           require("navigator.lspclient.mapping").setup({ client = c, bufnr = b })
--         end,
--       },
--     })
--   end,
--   ft = "rust",
--   lazy = true,
-- },
-- {
--   "Saecki/crates.nvim",
--   ft = "rust",
--   lazy = true,
-- },

-- {
--   "mfussenegger/nvim-jdtls",
--   ft = "java",
--   lazy = true,
-- },

-- {
--   "ray-x/go.nvim",
--   ft = "go",
--   lazy = true,
-- },

-- {
--   "folke/neodev.nvim",
--   ft = "lua",
--   lazy = true,
-- },

-- {
--   "kkharji/sqlite.lua",
--   ft = "sqlite",
--   lazy = true,
-- },

-- {
--   "p00f/clangd_extensions.nvim",
--   config = conf("clangd-extensions"),
--   ft = {
--     "c",
--     "cpp",
--     "objc",
--     "objcpp",
--     "h",
--     "hpp",
--   },
--   lazy = true,
-- },

-- {
--   "Valloric/MatchTagAlways",
--   ft = "html",
--   lazy = true,
-- },
-- {
--   "turbio/bracey.vim",
--   ft = "html",
--   lazy = true,
-- },
-- {
--   "mattn/emmet-vim",
--   ft = "html",
--   lazy = true,
-- },

-- {
--   "nvim-neorg/neorg",
--   config = conf("neorg"),
--   dependencies = {
--     { "nvim-neorg/neorg-telescope", ft = "norg" }
--   },
--   ft = "norg",
--   lazy = true,
-- },
-- {
--   "akinsho/org-bullets.nvim",
--   config = function()
--     require("org-bullets").setup()
--   end,
--   lazy = true,
-- },
-- {
--   "lukas-reineke/headlines.nvim",
--   ft = {
--     "org",
--     "norg",
--     "markdown",
--     "yaml",
--   },
--   config = conf("headlines"),
-- },

-- -- BBOX: Git
-- { "sindrets/diffview.nvim", lazy = true },
-- { "AndrewRadev/linediff.vim", lazy = true },
-- { "tpope/vim-fugitive", lazy = true },
-- { "tpope/vim-rhubarb", lazy = true },
-- { "ray-x/forgit.nvim", lazy = true },
-- { "TimUntersberger/neogit", lazy = true },

-- -- TODO: DO THIS!
-- { "pwntester/octo.nvim", lazy = true },

-- -- TODO: DO THIS!
-- { "mattn/vim-gist", lazy = true },

-- {
--   "akinsho/git-conflict.nvim",
--   lazy = true,
--   config = function()
--     require("git-conflict").setup()
--   end,
-- },

-- {
--   "lewis6991/gitsigns.nvim",
--   config = conf("git-signs"),
--   lazy = true,
-- },

-- -- TODO: DO THIS!
-- {
--   "ThePrimeagen/git-worktree.nvim",
--   config = conf("git-worktree"),
--   lazy = true,
-- },

-- -- BBOX: Themes
-- {
--   "wincent/base16-nvim",
--   config = conf("colorschemes").base16,
--   lazy = true,
-- },
-- {
--   "LunarVim/horizon.nvim",
--   config = function()
--     vim.cmd("colorscheme horizon")
--   end,
--   lazy = true,
-- },
-- {
--   "LunarVim/onedarker.nvim",
--   config = function()
--     vim.cmd("colorscheme onedarker")
--   end,
--   lazy = true,
-- },
-- {
--   "martinsione/darkplus.nvim",
--   config = function()
--     vim.cmd("colorscheme darkplus")
--   end,
--   lazy = true,
-- },
-- {
--   "flazz/vim-colorschemes",
--   config = conf("colorschemes").vim_colorschemes,
--   lazy = true,
-- },
-- {
--   "LunarVim/synthwave84.nvim",
--   config = function()
--     vim.cmd("colorscheme synthwave84")
--   end,
--   lazy = true,
-- },
-- {
--   "glepnir/zephyr-nvim",
--   config = function()
--     vim.cmd("colorscheme zephyr")
--   end,
--   lazy = true,
-- },
-- {
--   "ray-x/aurora",
--   config = function()
--     vim.cmd("colorscheme aurora")
--   end,
--   lazy = true,
--   setup = function()
--     vim.g.aurora_italic = 1
--     vim.g.aurora_transparent = 1
--     vim.g.aurora_bold = 1
--   end,
-- },
-- {
--   "folke/tokyonight.nvim",
--   config = conf("colorschemes").tokyonight,
--   lazy = true,
-- },
-- {
--   "projekt0n/github-nvim-theme",
--   config = conf("colorschemes").github_theme,
--   lazy = true,
-- },
-- {
--   "sainnhe/sonokai",
--   config = conf("colorschemes").sonokai,
--   lazy = true,
-- },
-- {
--   "sainnhe/gruvbox-material",
--   config = conf("colorschemes").gruvbox,
--   lazy = true,
-- },
-- {
--   "catppuccin/nvim",
--   as = "catppuccin",
--   config = conf("colorschemes").catppuccin,
--   lazy = true,
-- },
-- {
--   "ray-x/starry.nvim",
--   config = conf("colorschemes").starry,
--   lazy = true,
-- },
-- {
--   "sainnhe/everforest",
--   config = conf("colorschemes").everforest,
--   lazy = true,
-- },
-- {
--   "sainnhe/edge",
--   config = conf("colorschemes").edge,
--   lazy = true,
-- },
-- {
--   "EdenEast/nightfox.nvim",
--   config = conf("colorschemes").nightfox,
--   lazy = true,
-- },

require("lazy").setup({
  spec = {},
  defaults = { lazy = true },
  dev = { patterns = jit.os:find("Windows") and {} or { "folke" } },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true },
  diff = {
    cmd = "terminal_git",
  },
  performance = {
    cache = {
      enabled = true,
      disable_events = {},
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- utils.load_colorscheme()
