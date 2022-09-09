local M = {}

local cmp = require("cmp")
local icons = require("SingularisArt.icons")
local kind_icons = icons.kind

M.setup = function()
	require("cmp").setup({
		snippet = {
			expand = function(args)
				vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
				-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
				-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			end,
		},

		mapping = cmp.mapping.preset.insert({
			["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
			["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
			["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<m-o>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
			["<C-c>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			["<m-j>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			["<m-k>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			["<m-c>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			["<S-CR>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),

			["<CR>"] = cmp.mapping.confirm({ select = false }),
		}),
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				-- Kind icons
				vim_item.kind = string.format("%s", kind_icons[vim_item.kind])

				-- NOTE: order matters
				vim_item.menu = ({
					nvim_lsp = "",
					nvim_lua = "",
					latex_symbols = "",
					ultisnips = "",
					calc = "",
					path = "",
					buffer = "",
					gh_issues = "",
					emails = "",
					emoji = "",
				})[entry.source.name]
				return vim_item
			end,
		},
		sources = {
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "latex_symbols" },
			{ name = "ultisnips" },
			{ name = "calc" },
			{ name = "path" },
			{ name = "buffer" },
			{ name = "gh_issues" },
			{ name = "emails" },
			{ name = "emoji" },
		},
		confirm_opts = {
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		},
		window = {
			-- documentation = false,
			documentation = {
			  border = "rounded",
			  winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
			},
			completion = {
				border = "rounded",
				winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
			},
		},
		experimental = {
			ghost_text = true,
		},
	})

	require("SingularisArt.config.cmp.cmp_github_issues")
	require("SingularisArt.config.cmp.cmp_emails").setup()
end

return M
