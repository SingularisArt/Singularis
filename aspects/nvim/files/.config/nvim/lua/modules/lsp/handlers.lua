local lsp = {}

lsp.setup_codelens_refresh = function(client, bufnr)
  local status_ok, codelens_supported = pcall(function()
    return client.supports_method("textDocument/codeLens")
  end)

  if not status_ok or not codelens_supported then
    return
  end

  local group = "lsp_code_lens_refresh"
  local cl_events = { "BufEnter", "InsertLeave" }
  local ok, cl_autocmds = pcall(vim.api.nvim_get_autocmds, {
    group = group,
    buffer = bufnr,
    event = cl_events,
  })

  if ok and #cl_autocmds > 0 then
    return
  end
  vim.api.nvim_create_augroup(group, { clear = false })
  vim.api.nvim_create_autocmd(cl_events, {
    group = group,
    buffer = bufnr,
    callback = vim.lsp.codelens.refresh,
  })
end

lsp.attach_mappings = function(_, bufnr)
  vim.keymap.set("n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>", { buffer = true, silent = true })

  -- local which_key = require("which-key")
  -- local options = require("config.global").which_key_vars.options

  -- options = vim.tbl_deep_extend("force", {
  --   buffer = bufnr,
  -- }, options)

  -- which_key.add({
  --   { "<Leader>l",  group = "LSP" },
  --   { "<Leader>lc", vim.lsp.buf.code_action,          desc = "Show code actions" },
  --   { "<Leader>le", vim.diagnostic.open_float,        desc = "Show line diagnostics" },
  --   { "<Leader>lE", "<CMD>Telescope diagnostics<CR>", desc = "Show all diagnostics" },
  --   {
  --     "<Leader>lf",
  --     function()
  --       vim.lsp.buf.format({ async = true })
  --     end,
  --     desc = "Format",
  --   },
  --   { "<Leader>lr", vim.lsp.buf.rename,         desc = "Rename" },
  --   { "<Leader>li", vim.cmd.LspInfo,            desc = "LSP info" },
  --   { "<Leader>lo", vim.cmd.OutlineOpen,        desc = "Symbols Outline" },
  --   { "<Leader>lj", vim.diagnostic.goto_next,   desc = "Go to next diagnostic" },
  --   { "<Leader>lk", vim.diagnostic.goto_prev,   desc = "Go to previous diagnostic" },
  --   { "<Leader>ls", vim.lsp.buf.signature_help, desc = "Signature" },
  --   { "<Leader>lD", "<cmd>Namu symbols<cr>",    desc = "Document Symbols" },

  --   { "<Leader>ld", group = "Definition" },
  --   {
  --     "<Leader>ldp",
  --     function()
  --       require("nvim-treesitter.textobjects.lsp_interop").peek_definition_code(
  --         "@function.outer",
  --         nil,
  --         "textDocument/typeDefinition"
  --       )
  --     end,
  --     desc = "Preview Definition",
  --   },
  --   { "<Leader>ldd", "<CMD>Glance definitions<CR>",            desc = "Definitions" },
  --   { "<Leader>ldr", "<CMD>Glance references<CR>",             desc = "References" },
  --   { "<Leader>ldt", "<CMD>Glance type_definitions<CR>",       desc = "Type Definitions" },
  --   { "<Leader>ldi", "<CMD>Glance implementations<CR>",        desc = "Implementations" },
  --   { "<Leader>ldr", "<CMD>Glance resume<CR>",                 desc = "Resume" },

  --   { "<Leader>lt",  group = "Trouble" },
  --   { "<Leader>ltl", "<cmd>Trouble<cr>",                       desc = "Toggle Trouble" },
  --   { "<Leader>ltq", "<cmd>Trouble quickfix<cr>",              desc = "Toggle Trouble Quickfix" },
  --   { "<Leader>ltw", "<cmd>Trouble workspace_diagnostics<cr>", desc = "Toggle Trouble Workspace Diagnostics" },

  --   { "<Leader>lq",  group = "Quickfix" },
  --   { "<Leader>lqa", vim.diagnostic.setloclist,                desc = "Add diagnostics to quickfix list" },
  --   { "<Leader>lql", vim.diagnostic.setqflist,                 desc = "Set diagnostics to quickfix list" },

  --   { "<Leader>lw",  group = "Workspace" },
  --   { "<Leader>lws", vim.diagnostic.LspSymbols,                desc = "Symbols" },
  --   { "<Leader>lwa", vim.lsp.buf.add_workspace_folder,         desc = "Add workspace folder" },
  --   { "<Leader>lwr", vim.lsp.buf.remove_workspace_folder,      desc = "Remove workspace folder" },
  --   { "<Leader>lwl", vim.lsp.buf.list_workspace_folders,       desc = "List workspace folders" },
  -- })
end

lsp.on_attach = function(client, bufnr)
  lsp.attach_mappings(client, bufnr)

  -- if client.name == "jdtls" then
  --   require("jdtls").setup_dap({ hotcodereplace = "auto" })
  --   require("jdtls.dap").setup_dap_main_class_configs()

  --   vim.lsp.codelens.refresh()
  -- elseif client.name == "clangd" then
  --   require("modules.lsp.filetypes.cpp").clangd_extensions()
  -- end

  require("inlay-hints").on_attach(client, bufnr)
  if vim.bo.filetype ~= "TelescopePrompt" then
    lsp.setup_codelens_refresh(client, bufnr)
  end

  -- if client.name == "sqls" then
  --   require("sqls").on_attach(client, bufnr)
  -- elseif client.name == "gopls" then
  --   if not client.server_capabilities.semanticTokensProvider then
  --     local semantic = client.config.capabilities.textDocument.semanticTokens
  --     client.server_capabilities.semanticTokensProvider = {
  --       full = true,
  --       legend = {
  --         tokenTypes = semantic.tokenTypes,
  --         tokenModifiers = semantic.tokenModifiers,
  --       },
  --       range = true,
  --     }
  --   end
  -- elseif client.name == "yamlls" then
  --   client.server_capabilities.textDocument.foldingRange = {
  --     dynamicRegistration = false,
  --     lineFoldingOnly = false,
  --   }
  -- end

  require("colorizer").attach_to_buffer(bufnr)

  -- client.config.capabilities.textDocument.completion.completionItem.snippetSupport = true
  -- client.config.capabilities.textDocument.foldingRange = {
  --   dynamicRegistration = false,
  --   lineFoldingOnly = true,
  -- }

  -- lsp.capabilities = client.config.capabilities
end

return lsp
