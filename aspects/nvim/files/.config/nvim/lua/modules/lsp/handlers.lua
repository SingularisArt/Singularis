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

  local which_key = require("which-key")
  local options = require("config.global").which_key_vars.options

  options = vim.tbl_deep_extend("force", {
    buffer = bufnr,
  }, options)

  which_key.register({
    l = {
      name = "LSP",
      c = { "<CMD>lua vim.lsp.buf.code_action()<CR>", "Show code actions" },
      e = { "<CMD>lua vim.diagnostic.open_float()<CR>", "Show line diagnostics" },
      E = { "<CMD>Telescope diagnostics<CR>", "Show all diagnostics" },
      f = { "<CMD>lua vim.lsp.buf.format { async = true }<CR>", "Format" },
      r = { "<CMD>lua vim.lsp.buf.rename()<CR>", "Rename" },
      i = { "<CMD>LspInfo<CR>", "LSP info" },
      o = { "<CMD>SymbolsOutline<CR>", "Symbols Outline" },
      j = { "<CMD>lua vim.diagnostic.goto_next()<CR>", "Go to next diagnostic" },
      k = { "<CMD>lua vim.diagnostic.goto_prev()<CR>", "Go to previous diagnostic" },
      l = { "<CMD>lua require('lsp_lines').toggle()<CR>", "Toggle LSP Lines" },
      s = { "<CMD>lua vim.lsp.buf.signature_help()<CR>", "Signature" },
      S = { "<CMD>LspSymbols<CR>", "Toggle symbols outline" },
      D = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
      d = {
        name = "Definition",
        d = { "<CMD>Glance definitions<CR>", "Definition" },
        p = {
          function()
            require("nvim-treesitter.textobjects.lsp_interop").peek_definition_code("@function.outer", nil, "textDocument/typeDefinition")
          end,
          "Preview Definition"
        },
        r = { "<CMD>Glance references<CR>", "References" },
        t = { "<CMD>Glance type_definitions<CR>", "Type Definition" },
        i = { "<CMD>Glance implementations<CR>", "Implementation" },
      },
      w = {
        name = "Workspace",
        s = { "<CMD>Telescope lsp_workspace_symbols<CR>", "Symbols" },
        a = { "<CMD>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add workspace folder" },
        r = { "<CMD>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove workspace folder" },
        l = { "<CMD>lua vim.lsp.buf.list_workspace_folders()<CR>", "List workspace folders" },
      },
    },
  }, options)
end

lsp.on_attach = function(client, bufnr)
  local servers_that_dont_work_with_navic = {
    "tailwindcss",
    "emmet_ls",
  }

  if client.name == "jdtls" then
    require("jdtls").setup_dap({ hotcodereplace = "auto" })
    require("jdtls.dap").setup_dap_main_class_configs()

    vim.lsp.codelens.refresh()
  elseif client.name == "clangd" then
    require("modules.lsp.filetypes.cpp").clangd_extensions()
  end

  -- require("inlay-hints").on_attach(client, bufnr)
  lsp.setup_codelens_refresh(client, bufnr)
  lsp.attach_mappings(client, bufnr)

  if client.name == "sqls" then
    require("sqls").on_attach(client, bufnr)
  elseif client.name == "gopls" then
    if not client.server_capabilities.semanticTokensProvider then
      local semantic = client.config.capabilities.textDocument.semanticTokens
      client.server_capabilities.semanticTokensProvider = {
        full = true,
        legend = {
          tokenTypes = semantic.tokenTypes,
          tokenModifiers = semantic.tokenModifiers,
        },
        range = true,
      }
    end
  end

  if servers_that_dont_work_with_navic[client.name] ~= nil then
    require("nvim-navic").attach(client, bufnr)
  end

  require("colorizer").attach_to_buffer(bufnr)

  client.config.capabilities.textDocument.completion.completionItem.snippetSupport = true
  client.config.capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  }

  lsp.capabilities = client.config.capabilities

  -- if client.resolved_capabilities.code_lens then
  --   local codelens = vim.api.nvim_create_augroup(
  --     "LSPCodeLens",
  --     { clear = true }
  --   )
  --   vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "CursorHold" }, {
  --     group = codelens,
  --     callback = function()
  --       vim.lsp.codelens.refresh()
  --     end,
  --     buffer = bufnr,
  --   })
  -- end
end

return lsp
