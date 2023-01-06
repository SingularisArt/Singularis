return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
    },
    config = function()
      -- diagnostics
      for name, icon in pairs(require("lazyvim.config.icons").diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end
    end,
  },

  -- server configuration
  {
    "ray-x/navigator.lua",
    event = "BufReadPre",
    config = function()
      require("lazyvim.plugins.lsp.navigator")
    end,
    dependencies = {
      "ray-x/guihua.lua",
      {
        "ray-x/lsp_signature.nvim",
        config = function()
          local icons = require("lazyvim.config.icons")

          local signature_help_setup = {
            bind = true,
            doc_lines = 0,
            max_height = 10,
            max_width = 80,
            wrap = true,
            floating_window = true,
            floating_window_above_cur_line = true,
            floating_window_off_x = 1,
            floating_window_off_y = 0,
            fix_pos = false,
            hint_enable = true,
            hi_parameter = "LspSignatureActiveParameter",
            toggle_key = "<C-x>",
            hint_prefix = icons.misc.Squirrel .. " ",
            hint_scheme = "Comment",
            handler_opts = {
              border = "rounded",
            },
          }

          require("lsp_signature").setup(signature_help_setup)
        end,
      },
    },
  },

  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    config = function()
      local null_ls = require("null-ls")

      local diagnostics = null_ls.builtins.diagnostics
      local formatting = null_ls.builtins.formatting
      local actions = null_ls.builtins.code_actions
      local code_actions = null_ls.builtins.code_actions

      local sources = {
        formatting.rustfmt,
        formatting.google_java_format,
        formatting.sql_formatter,
        formatting.stylua,
        formatting.shellharden,
        formatting.clang_format,
        formatting.trim_newlines,
        formatting.trim_whitespace,
        formatting.prettier.with({
          extra_filetypes = { "toml", "solidity" },
          extra_args = { "--arrow-parens always", "--trailing-comma all" },
        }),
        formatting.golines.with({
          extra_args = {
            "--max-len=180",
            "--base-formatter=gofumpt",
          },
        }),
        formatting.standardrb.with({
          extra_filetypes = { "--fix", "--format", "quiet", "--stderr", "--stdin", "$FILENAME" },
        }),
        formatting.black.with({
          extra_args = { "--fast" },
        }),

        diagnostics.yamllint,
        diagnostics.shellcheck,
        diagnostics.golangci_lint,

        code_actions.gitsigns,
        code_actions.proselint,
        code_actions.refactoring,

        diagnostics.misspell.with({
          filetypes = { "markdown", "text", "txt" },
          args = { "$FILENAME" },
        }),
        diagnostics.write_good.with({
          filetypes = { "markdown", "tex", "" },
          extra_filetypes = { "txt", "text" },
          args = { "--text=$TEXT", "--parse" },
          command = "write-good",
        }),
        diagnostics.proselint.with({
          filetypes = { "markdown", "tex" },
          extra_filetypes = { "txt", "text" },
          command = "proselint",
          args = { "--json" },
        }),

        actions.proselint.with({ filetypes = { "markdown", "tex" }, command = "proselint", args = { "--json" } }),
      }

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
        on_attach = function(client)
          if client.server_capabilities.documentFormatting then
            vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
          end
        end,
      }

      null_ls.setup(setup)
    end,
  },

  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          require("mason-lspconfig").setup({
            automatic_installation = true,
          })
        end
      },
      {
        "jay-babu/mason-nvim-dap.nvim",
        config = function()
          require("mason-nvim-dap").setup({
            automatic_installation = true,
          })
        end
      },
      {
        "jay-babu/mason-null-ls.nvim",
        config = function()
          require("mason-null-ls").setup({
            automatic_installation = true,
          })
        end
      },
    },
    lazy = true,
  },
}
