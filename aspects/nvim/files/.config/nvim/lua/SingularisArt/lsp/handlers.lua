local M = {}

M.capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  local cmp_nvim_lsp = require("cmp_nvim_lsp")
  capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

  return capabilities
end

M.load = function()
  local signs = SingularisArt.lsp.config.diagnostics.signs.values

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = SingularisArt.lsp.config.diagnostics

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
    -- width = 60,
    -- height = 30,
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
    -- width = 60,
    -- height = 30,
  })
end

local function attach_navic(client, bufnr)
  vim.g.navic_silence = true

  local navic = require("nvim-navic")
  navic.attach(client, bufnr)
end

local function attach_inlay_hints(client, bufnr)
  local inlay_hints = require("lsp-inlayhints")
  inlay_hints.on_attach(client, bufnr)
end

local function setup_codelens_refresh(client, bufnr)
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

M.on_attach = function(client, bufnr)
  vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { buffer = true, silent = true })

  attach_navic(client, bufnr)
  attach_inlay_hints(client, bufnr)
  setup_codelens_refresh(client, bufnr)

  if client.name == "sqls" then
    require("sqls").on_attach(client, bufnr)
  end
end

return M
