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

lsp.attach_inlay_hints = function(client, bufnr)
  local status, inlay_hints = pcall(require, "lsp-inlayhints")
  if not status then
    return
  end

  local setup = {
    inlay_hints = {
      parameter_hints = {
        show = true,
        separator = ", ",
      },
      type_hints = {
        show = true,
        prefix = "",
        separator = ", ",
        remove_colon_end = false,
        remove_colon_start = false,
      },
      labels_separator = "  ",
      max_len_align = false,
      max_len_align_padding = 1,
      right_align = false,
      right_align_padding = 7,
      highlight = "Comment",
    },
    debug_mode = false,
  }

  inlay_hints.setup(setup)
  inlay_hints.on_attach(client, bufnr)
end

lsp.attach_mappings = function(_, bufnr)
  vim.keymap.set("n", "K", "<CMD>Lspsaga hover_doc<CR>", { buffer = true, silent = true })

  -- local which_key = require("which-key")
  local options = require("SingularisArt.local-variables").options

  -- options = vim.tbl_deep_extend("force", {
  --   buffer = bufnr,
  -- }, options)

  -- which_key.register({
  --   l = {
  --     name = "LSP",
  --     c = { "<CMD>lua require('navigator.codeAction').code_action()<CR>", "Show code actions" },
  --     e = { "<CMD>lua require('navigator.diagnostics').show_diagnostics()<CR>", "Show line diagnostics" },
  --     E = { "<CMD>lua require('navigator.diagnostics').show_buf_diagnostics()<CR>", "Show diagnostic for all buffers" },
  --     f = { "<CMD>lua vim.lsp.buf.format { async = true }<CR>", "Format" },
  --     r = { "<CMD>lua require('navigator.rename').rename()<CR>", "Rename" },
  --     i = { "<CMD>lua vim.lsp.buf.implementation()<CR>", "Go to implementation" },
  --     j = { "<CMD>lua vim.diagnostic.goto_next()<CR>", "Go to next diagnostic" },
  --     J = { "<CMD>lua require('navigator.treesitter').goto_next_usage()<CR>", "Go to next highlight" },
  --     k = { "<CMD>lua vim.diagnostic.goto_prev()<CR>", "Go to previous diagnostic" },
  --     K = { "<CMD>lua require('navigator.treesitter').goto_previous_usage()<CR>", "Go to previous highlight" },
  --     l = { "<CMD>lua require('lsp_lines').toggle()<CR>", "Toggle LSP Lines" },
  --     L = { "<CMD>lua require('navigator.diagnostics').toggle_diagnostics()<CR>", "Toggle diagnostics completely" },
  --     s = { "<CMD>LspSymbols<CR>", "Toggle symbols outline" },
  --     d = {
  --       name = "Definition",
  --       d = { "<CMD>lua require('navigator.reference').async_ref()<CR>", "Definition" },
  --       p = { "<CMD>lua require('navigator.definition').definition_preview()<CR>", "Peek" },
  --       t = { "<CMD>lua vim.lsp.buf.type_definition()<CR>", "Type Definition" },
  --       i = { "<CMD>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
  --     },
  --     w = {
  --       name = "Workspace",
  --       a = { "<CMD>lua require('navigator.workspace').add_workspace_folder()<CR>", "Add workspace folder" },
  --       r = { "<CMD>lua require('navigator.workspace').remove_workspace_folder()<CR>", "Remove workspace folder" },
  --       l = { "<CMD>lua require('navigator.workspace').list_workspace_folders()<CR>", "List workspace folders" },
  --     },
  --   },
  -- }, options)
end

lsp.on_attach = function(client, bufnr)
  lsp.setup_codelens_refresh(client, bufnr)
  lsp.attach_inlay_hints(client, bufnr)
  lsp.attach_mappings(client, bufnr)
end

return lsp
