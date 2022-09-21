local M = {}

function M.setup()
	require("neorg").setup({
		load = {
			["core.defaults"] = {},
			["core.keybinds"] = {
				config = {
					neorg_leader = "<Leader>",
				},
			},
			["core.syntax"] = {},
			["core.autocommands"] = {
				config = {
					vimleavepre = true,
				},
			},
			["core.highlights"] = {},
			["core.presenter"] = {
				config = {
					zen_mode = "zen-mode",
				},
			},
			["core.ui"] = {},

			["core.neorgcmd"] = {},
			["core.neorgcmd.commands.return"] = {},
			["core.neorgcmd.commands.module.load"] = {},

			-- ["core.norg.esupports"] = {},
			["core.norg.esupports.hop"] = {},
			["core.norg.concealer"] = {},
			["core.norg.completion"] = {
				config = {
					engine = "nvim-cmp",
				},
			},
			["core.norg.dirman"] = {
				config = {
					workspaces = {
						college = "~/Documents/school-notes/notes/college",
						home = "~/Documents/school-notes/notes/personal",
					},
					autochdir = true,
					index = "index.norg",
				},
			},
			["core.norg.qol.toc"] = {},
			["core.norg.manoeuvre"] = {},
			["core.norg.esupports.metagen"] = {},
			["core.norg.journal"] = {},

			["core.integrations.telescope"] = {},
		},
	})
end

return M
