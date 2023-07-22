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
      j = { "<CMD>lua vim.diagnostic.goto_next()<CR>", "Go to next diagnostic" },
      k = { "<CMD>lua vim.diagnostic.goto_prev()<CR>", "Go to previous diagnostic" },
      l = { "<CMD>lua require('lsp_lines').toggle()<CR>", "Toggle LSP Lines" },
      s = { "<CMD>lua vim.lsp.buf.signature_help()<CR>", "Signature" },
      S = { "<CMD>LspSymbols<CR>", "Toggle symbols outline" },
      D = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
      d = {
        name = "Definition",
        d = { "<CMD>Telescope lsp_definitions<CR>", "Definition" },
        r = { "<CMD>Telescope lsp_references<CR>", "References" },
        p = { "<CMD>lua vim.diagnostic.open_float()<CR>", "Peek" },
        t = { "<CMD>lua lsp_type_definitions<CR>", "Type Definition" },
        i = { "<CMD>lua Telescope lsp_implementations<CR>", "Implementation" },
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

  -- require("lsp-inlayhints").on_attach(client, bufnr)

  if servers_that_dont_work_with_navic[client.name] ~= nil then
    require("nvim-navic").attach(client, bufnr)
  end

  lsp.setup_codelens_refresh(client, bufnr)
  lsp.attach_mappings(client, bufnr)
end

return lsp
