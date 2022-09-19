local lsp = {}

local on_attach = function(client, bufnr)
	vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { buffer = true, silent = true })
	vim.wo.signcolumn = "yes"

	require("lsp-inlayhints").on_attach(client, bufnr)
end

local sql_on_attach = function(client, bufnr)
	on_attach(client, bufnr)
	require("sqls").on_attach(client, bufnr)
end

lsp.load = function()
	local servers = {
		"bashls",
		"clangd",
		"cssls",
		"cssmodules_ls",
		"emmet_ls",
		"golangci_lint_ls",
		"html",
		"jdtls",
		"jsonls",
		"pylsp",
		"rust_analyzer",
		"solang",
		"solc",
		"solidity_ls",
		"sumneko_lua",
		"sqls",
		"tailwindcss",
		"texlab",
		"tsserver",
		"yamlls",
	}

	local capabilities = vim.lsp.protocol.make_client_capabilities()

	-- UI tweaks from https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
	local border = {
		{ "╭", "FloatBorder" },
		{ "─", "FloatBorder" },
		{ "╮", "FloatBorder" },
		{ "│", "FloatBorder" },
		{ "╯", "FloatBorder" },
		{ "─", "FloatBorder" },
		{ "╰", "FloatBorder" },
		{ "│", "FloatBorder" },
	}
	local handlers = {
		["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
		["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
	}

	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

	local mason = require("mason")
	local mason_lspconfig = require("mason-lspconfig")

	local settings = {
		ui = {
			border = "rounded",
			icons = {
				package_installed = "◍",
				package_pending = "◍",
				package_uninstalled = "◍",
			},
		},
		max_concurrent_installers = 4,
	}

	mason.setup(settings)
	mason_lspconfig.setup({
		ensure_installed = servers,
		automatic_installation = true,
	})

	local lspconfig = require("lspconfig")
	local server_settings = {}

	for _, server in ipairs(servers) do
		server_settings = {
			capabilities = capabilities,
			handlers = handlers,
			on_attach = on_attach,
		}

		if server == "sqls" then
			server_settings.on_attach = sql_on_attach
		end

		server_settings = vim.tbl_deep_extend("force", SingularisArt.lsp.settings[server], server_settings)

		lspconfig[server].setup(server_settings)
	end

	require("mason-null-ls").setup({
		automatic_installation = true,
	})
  require("mason-null-ls").check_install(true)
end

return lsp
