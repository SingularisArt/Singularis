local lsp = {}

lsp.capabilities = function()
  local status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if not status then
    return
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
  vim.lsp.handlers["textDocument/references"] = vim.lsp.with(vim.lsp.handlers["textDocument/references"], {
    loclist = true,
  })
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
  })

  return capabilities
end

lsp.load = function()
  local signs = SingularisArt.lsp.config.diagnostics.signs.values

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = SingularisArt.lsp.config.diagnostics

  vim.diagnostic.config(config)
end

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

lsp.attach_navic = function(client, bufnr)
  local status, navic = pcall(require, "nvim-navic")
  if not status then
    return
  end

  vim.g.navic_silence = true
  navic.attach(client, bufnr)
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

lsp.attach_signature = function(client, bufnr)
  local status, signature = pcall(require, "lsp_signature")
  if not status then
    return
  end

  local icons = require("SingularisArt.icons")
  local setup = {
    debug = false,
    verbose = false,
    bind = true,
    doc_lines = 0,
    floating_window = false,
    floating_window_above_cur_line = false,
    fix_pos = false,
    hint_enable = true,
    hint_prefix = icons.misc.Squirrel .. " ",
    hint_scheme = "Comment",
    use_lspsaga = false,
    hi_parameter = "LspSignatureActiveParameter",
    max_height = 12,
    max_width = 120,
    handler_opts = {
      border = "rounded",
    },
    always_trigger = false,
    auto_close_after = nil,
    extra_trigger_chars = {},
    zindex = 200,
    padding = "",
    transparency = nil,
    shadow_blend = 36,
    shadow_guibg = "Black",
    timer_interval = 200,
    toggle_key = nil,
  }

  signature.setup(setup)
  signature.on_attach(setup, client, bufnr)
end

lsp.attach_sqls = function(client, bufnr)
  if client.name == "sqls" then
    local status, sqls = pcall(require, "sqls")
    if not status then
      return
    end

    sqls.on_attach(client, bufnr)
  end
end

lsp.on_attach = function(client, bufnr)
  vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { buffer = true, silent = true })

  lsp.setup_codelens_refresh(client, bufnr)
  lsp.attach_navic(client, bufnr)
  lsp.attach_inlay_hints(client, bufnr)
  lsp.attach_signature(client, bufnr)
  lsp.attach_sqls(client, bufnr)
end

return lsp
