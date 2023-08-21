local M = {}

M.servers = {
  emmet_ls = require("plugins.lsp.settings.emmet_ls"),
  jsonls = require("plugins.lsp.settings.jsonls"),
  pyright = require("plugins.lsp.settings.pyright"),
  rust_analyzer = require("plugins.lsp.settings.rust_analyzer"),
  solang = require("plugins.lsp.settings.solang"),
  solc = require("plugins.lsp.settings.solc"),
  lua_ls = require("plugins.lsp.settings.lua_ls"),
  cssmodules_ls = { filetypes = { "css" }, install = true },
  dartls = { filetypes = { "dart" } },
  solargraph = { filetypes = { "ruby" } },
  tsserver = require("plugins.lsp.settings.tsserver"),
  yamlls = require("plugins.lsp.settings.yamlls"),
  sqlls = require("plugins.lsp.settings.sqlls"),
  cssls = { filetypes = { "css" }, install = true },
  html = require("plugins.lsp.settings.html"),
  texlab = require("plugins.lsp.settings.texlab"),
  bashls = { filetypes = { "bash" }, install = true },
  clangd = require("plugins.lsp.settings.clangd"),
  tailwindcss = {
    filetypes = {
      "html",
      "css",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact"
    },
    install = true
  },
  golangci_lint_ls = { filetypes = { "go", "gomod" }, install = true },
  gopls = require("plugins.lsp.settings.gopls"),
  jdtls = { filetypes = { "java" }, install = true },
  solidity_ls = { filetypes = { "solidity" }, install = true, install_server_name = "solidity" },
  r_language_server = { filetypes = { "r" }, install = false },
  lemminx = { filetypes = { "xml" }, install = true },
  marksman = { filetypes = { "markdown" }, install = true },
  zls = { filetypes = { "zig" }, install = true },
  ocamllsp = require("plugins.lsp.settings.ocaml"),
}

M.formatters = {
  -- Python
  "black",

  -- Go
  golines = {
    options = {
      extra_args = {
        "--max-len=180",
        "--base-formatter=gofumpt",
      },
    },
  },
  "gofumpt",
  ["goimports-reviser"] = {
    null_ls_source = "goimports_reviser",
  },

  -- JS/TS
  prettier = {
    options = {
      extra_filetypes = { "toml", "solidity" },
      extra_args = { "--arrow-parens always", "--trailing-comma all" },
    },
  },

  -- Ruby
  standardrb = {
    options = {
      extra_filetypes = { "--fix", "--format", "quiet", "--stderr", "--stdin", "$FILENAME" },
    },
  },

  -- C++/C
  ["clang-format"] = {
    null_ls_source = "clang_format",
  },

  -- Java
  ["google-java-format"] = {
    null_ls_source = "google_java_format",
  },

  -- SQL
  ["sql-formatter"] = {
    null_ls_source = "sql_formatter",
  },

  -- XML
  xmlformatter = {
    null_ls_source = "xmlformat",
  },

  -- Rust
  "rustfmt",

  -- Bash
  "shellharden",

  -- Markdown
  ["markdown-toc"] = {
    null_ls_source = "markdown_toc",
  },
  "mdformat",

  -- Lua
  "stylua",

  -- Yaml
  "yamlfmt",

  -- Ocaml
  "ocamlformat",

  -- JSON
  "fixjson",

  -- CMake
  "gersemi",

  -- HTML
  "htmlbeautifier",

  -- PhP
  "phpcbf",

  -- Toml
  "taplo",
}

M.linters = {
  -- Markdown
  write_good = {
    options = {
      filetypes = { "markdown" },
      extra_filetypes = { "txt", "text" },
      args = { "--text=$TEXT", "--parse" },
      command = "write-good",
    },
  },
  proselint = {
    options = {
      filetypes = { "markdown" },
      extra_filetypes = { "txt", "text" },
      command = "proselint",
      args = { "--json" },
    },
  },
  misspell = {
    options = {
      filetypes = { "markdown", "text", "txt" },
      args = { "$FILENAME" },
    },
  },
  "alex",
  "markdownlint",
  "markuplint",
  "textlint",

  -- C++/C
  "cpplint",

  -- All
  -- "cspell",
  -- "gitlint",

  -- Python
  "flake8",
  "ruff",
  "pydocstyle",

  -- Go
  "golangci_lint",
  "revive",

  -- Lua
  "selene",
  "luacheck",

  -- PhP
  "phpcs",
  "phpmd",

  -- Ruby
  "standardrb",

  -- Yaml
  "actionlint",
  "yamllint",

  -- Java
  "checkstyle",

  -- CMake
  "cmake_lint",

  -- Docker
  "hadolint",

  -- JSON
  "jsonlint",

  -- Kotlin
  "ktlint",

  -- Ruby
  "rubocop",

  -- Bash
  "shellcheck",

  -- Solidity
  "solhint",

  -- SQL
  "sqlfluff",
}

M.code_actions = {
  -- All
  -- "cspell",
  -- "refactoring",
  -- "gitsigns",

  -- Markdown
  proselint = {
    options = {
      filetypes = { "markdown" },
      command = "proselint",
      args = { "--json" },
    },
  },

  -- Go
  "gomodifytags",
}

M.dap = {
  "chrome-debug-adapter",
  "node-debug2-adapter",
  "php-debug-adapter",
  "js-debug-adapter",
  "go-debug-adapter",
  "dart-debug-adapter",
  "cpptools",
  "bash-debug-adapter",
  "codelldb",
  "debugpy",
  "java-debug-adapter",
  "java-test",
}

return M
