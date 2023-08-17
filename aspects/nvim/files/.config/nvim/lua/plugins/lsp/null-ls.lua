local null_ls = require("null-ls")

local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions

local pformatters = require("plugins.lsp.config").formatters
local plinters = require("plugins.lsp.config").linters
local pcode_actions = require("plugins.lsp.config").code_actions

local sources = {}
local cur_formatter

for k, v in pairs(pformatters) do
  if v["null_ls_source"] ~= nil then
    cur_formatter = v["null_ls_source"]
  else
    if type(v) == "table" then
      cur_formatter = k
    else
      cur_formatter = v
    end
  end

  if v["options"] ~= nil then
    cur_formatter = formatting[cur_formatter].with(v["options"])
  else
    cur_formatter = formatting[cur_formatter]
  end

  table.insert(sources, cur_formatter)
end

for _, linter in ipairs(plinters) do
  table.insert(sources, diagnostics[linter])
end

for _, code_action in ipairs(pcode_actions) do
  table.insert(sources, code_actions[code_action])
end

table.insert(
  sources,
  require("null-ls.helpers").make_builtin({
    method = require("null-ls.methods").internal.DIAGNOSTICS,
    filetypes = { "java" },
    generator_opts = {
      command = "java",
      args = { "$FILENAME" },
      to_stdin = false,
      format = "raw",
      from_stderr = true,
      on_output = require("null-ls.helpers").diagnostics.from_errorformat([[%f:%l: %trror: %m]], "java"),
    },
    factory = require("null-ls.helpers").generator_factory,
  })
)

local setup = {
  sources = sources,
  debounce = 1000,
  default_timeout = 3000,
  fallback_severity = vim.diagnostic.severity.WARN,
  root_dir = require("lspconfig").util.root_pattern(
    ".null-ls-root",
    "Makefile",
    ".git",
    "go.mod",
    "main.go",
    "package.json",
    "tsconfig.json"
  ),
  on_init = function(new_client, _)
    if vim.tbl_contains({ "h", "cpp", "c" }, vim.o.ft) then
      new_client.offset_encoding = "utf-16"
    end
  end,
}

null_ls.setup(setup)
