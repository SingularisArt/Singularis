local M = {}

M.servers = {
  emmet_ls = require("modules.lsp.settings.emmet_ls"),
  -- jsonls = require("modules.lsp.settings.jsonls"),
  pyright = require("modules.lsp.settings.pyright"),
  rust_analyzer = require("modules.lsp.settings.rust_analyzer"),
  solang = require("modules.lsp.settings.solang"),
  solc = require("modules.lsp.settings.solc"),
  lua_ls = require("modules.lsp.settings.lua_ls"),
  cssmodules_ls = { filetypes = { "css" }, install = true },
  dartls = { filetypes = { "dart" } },
  solargraph = { filetypes = { "ruby" } },
  -- ts_ls = require("modules.lsp.settings.tsserver"),
  -- yamlls = require("modules.lsp.settings.yamlls"),
  sqlls = require("modules.lsp.settings.sqlls"),
  cssls = { filetypes = { "css" }, install = true },
  html = require("modules.lsp.settings.html"),
  -- texlab = require("modules.lsp.settings.texlab"),
  bashls = { filetypes = { "bash" }, install = true },
  clangd = require("modules.lsp.settings.clangd"),
  tailwindcss = {
    filetypes = {
      "html",
      "css",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
    },
    install = true,
  },
  golangci_lint_ls = { filetypes = { "go", "gomod" }, install = true },
  -- gopls = require("modules.lsp.settings.gopls"),
  jdtls = { filetypes = { "java" }, install = true },
  solidity_ls = { filetypes = { "solidity" }, install = true, install_server_name = "solidity" },
  r_language_server = { filetypes = { "r" }, install = false },
  lemminx = { filetypes = { "xml" }, install = true },
  -- marksman = { filetypes = { "markdown" }, install = true },
  zls = { filetypes = { "zig" }, install = true },
  ocamllsp = require("modules.lsp.settings.ocaml"),
  omnisharp = {},
}

M.formatters = {
  -- Python
  "black",
  "isort",

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
      filetypes = {
        "javascript",
        "typescript",
        "css",
        "scss",
        "html",
        "json",
        "yaml",
        -- "markdown",
        "graphql",
        "md",
        "txt",
      },
      only_local = "node_modules/.bin",
    },
  },
  -- prettier = {
  --   options = {
  --     extra_filetypes = { "toml", "solidity" },
  --     extra_args = { "--arrow-parens always", "--trailing-comma all" },
  --   },
  -- },

  -- Ruby
  -- standardrb = {
  --   options = {
  --     extra_filetypes = { "--fix", "--format", "quiet", "--stderr", "--stdin", "$FILENAME" },
  --   },
  -- },

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
  -- xmlformatter = {
  --   null_ls_source = "xmlformat",
  -- },

  -- Rust
  -- "rustfmt",

  -- Bash
  "shellharden",

  -- Markdown
  -- ["markdown-toc"] = {
  --   null_ls_source = "markdown_toc",
  -- },
  -- "mdformat",

  -- Lua
  "stylua",

  -- Yaml
  "yamlfmt",

  -- -- Ocaml
  -- "ocamlformat",

  -- JSON
  -- "fixjson",

  -- CMake
  "gersemi",

  -- HTML
  -- "htmlbeautifier",

  -- PhP
  "phpcbf",

  -- Toml
  -- "taplo",
}

M.linters = {
  -- Markdown
  -- write_good = {
  --   options = {
  --     filetypes = { "markdown" },
  --     extra_filetypes = { "txt", "text" },
  --     args = { "--text=$TEXT", "--parse" },
  --     command = "write-good",
  --   },
  -- },
  -- proselint = {
  --   options = {
  --     filetypes = { "markdown" },
  --     extra_filetypes = { "txt", "text" },
  --     command = "proselint",
  --     args = { "--json" },
  --   },
  -- },
  -- misspell = {
  --   options = {
  --     filetypes = { "markdown", "text", "txt" },
  --     args = { "$FILENAME" },
  --   },
  -- },
  -- "alex",
  -- "markdownlint",
  -- "markuplint",
  -- "textlint",

  -- C++/C
  -- "cpplint",

  -- All
  -- "cspell",
  -- "gitlint",

  -- Python
  -- "flake8",
  -- "ruff",
  -- "pydocstyle",

  -- JS/TS
  -- "eslint-lsp",

  -- Go
  "golangci_lint",
  "revive",

  -- Lua
  "selene",
  -- "luacheck",

  -- PhP
  "phpcs",
  "phpmd",

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
  -- "jsonlint",

  -- Kotlin
  "ktlint",

  -- Ruby
  -- "rubocop",

  -- Bash
  -- "shellcheck",

  -- Solidity
  "solhint",

  -- SQL
  "sqlfluff",
}

M.code_actions = {
  -- All
  -- "cspell",
  "refactoring",
  -- "gitsigns",

  -- Markdown
  -- proselint = {
  --   options = {
  --     filetypes = { "markdown" },
  --     command = "proselint",
  --     args = { "--json" },
  --   },
  -- },

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
