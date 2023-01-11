require("lazyvim.config.lazy")

-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
--   vim.fn.system({
--     "git",
--     "clone",
--     "--filter=blob:none",
--     "https://github.com/folke/lazy.nvim.git",
--     "--branch=stable",
--     lazypath,
--   })
-- end
-- vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- require("lazy").setup({
--   {
--     "SirVer/ultisnips",
--     config = function()
--       vim.g.UltiSnipsRemoveSelectModeMappings = 0
--       vim.g.UltiSnipsEditSplit = "tabdo"
--       vim.g.UltiSnipsSnippetDirectories = {
--         "~/.config/nvim/UltiSnips", "UltiSnips"
--       }
--     end,
--     lazy = false,
--   },

--   -- auto completion
--   {
--     "hrsh7th/nvim-cmp",
--     config = function()
--       local cmp = require("cmp")
--       local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

--       local kind_icons = require("lspkind")
--       local duplicates = {
--         buffer = 1,
--         path = 1,
--         nvim_lsp = 0,
--       }

--       local source_names = {
--         nvim_lsp = "(LSP)",
--         nvim_lua = "(Lua)",
--         ultisnips = "(Snippets)",
--         calc = "(Calc)",
--         path = "(Path)",
--         buffer = "(Buffer)",
--       }

--       local cmp_sources = {
--         { name = "nvim_lsp" },
--         { name = "nvim_lua" },
--         { name = "ultisnips" },
--         { name = "calc" },
--         { name = "path" },
--         { name = "buffer" },
--       }

--       cmp.setup({
--         snippet = {
--           expand = function(args)
--             vim.fn["UltiSnips#Anon"](args.body)
--           end,
--         },

--         mapping = cmp.mapping.preset.insert({
--           ["<CR>"] = cmp.mapping({
--             i = function(fallback)
--               cmp_ultisnips_mappings.compose { "expand" } (fallback)
--             end,
--           }),

--           ["<C-j>"] = cmp.mapping({
--             i = function(fallback)
--               cmp_ultisnips_mappings.compose { "jump_forwards" } (fallback)
--             end,
--           }),

--           ["<C-k>"] = cmp.mapping({
--             i = function(fallback)
--               cmp_ultisnips_mappings.compose { "jump_backwards" } (fallback)
--             end,
--           }),
--         }),

--         formatting = {
--           fields = { "kind", "abbr", "menu" },

--           format = function(entry, vim_item)
--             local max_width = 50
--             if max_width ~= 0 and #vim_item.abbr > max_width then
--               vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. icons.ui.Ellipsis
--             end

--             vim_item.menu = ({
--               omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
--               buffer = "[Buffer]",
--             })[entry.source.name]
--             vim_item.kind = kind_icons[vim_item.kind]
--             vim_item.menu = source_names[entry.source.name]
--             vim_item.dup = duplicates[entry.source.name]
--             return vim_item
--           end,
--         },
--         sources = cmp_sources,
--       })
--     end,
--     dependencies = {
--       "hrsh7th/cmp-nvim-lsp",
--       "hrsh7th/cmp-nvim-lua",
--       "hrsh7th/cmp-buffer",
--       "hrsh7th/cmp-calc",
--       "hrsh7th/cmp-path",
--       "quangnguyen30192/cmp-nvim-ultisnips",
--       "onsails/lspkind.nvim",
--     },
--     lazy = false,
--   },
-- })
