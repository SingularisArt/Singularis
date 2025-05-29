local config = {}

function config.nvim_lsp()
  -- local mason = require("mason-lspconfig")
  local conf = require("modules.lsp.lsp_config")
  local servers = conf.servers
  local icons = require("config.global").icons

  vim.diagnostic.config({
    virtual_text = false,
  })

  for name, icon in pairs(icons.diagnostics) do
    name = "DiagnosticSign" .. name
    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
  end

  local ensure_installed = {}
  for server, server_opts in pairs(servers) do
    if server_opts["install"] == true then
      local server_name = server_opts["install_server_name"] or server
      ensure_installed[#ensure_installed + 1] = server_name
    end
  end

  -- mason.setup({ ensure_installed = ensure_installed })
end

function config.null_ls()
  local null_ls = require("null-ls")

  local diagnostics = null_ls.builtins.diagnostics
  local formatting = null_ls.builtins.formatting
  local code_actions = null_ls.builtins.code_actions

  local pformatters = require("modules.lsp.lsp_config").formatters
  local plinters = require("modules.lsp.lsp_config").linters
  local pcode_actions = require("modules.lsp.lsp_config").code_actions

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
end

function config.mason_null_ls()
  local conf = require("modules.lsp.lsp_config")
  local formatters = conf.formatters
  local linters = conf.linters
  local code_actions = conf.code_actions

  local ensure_installed = {}
  for k, v in pairs(formatters) do
    if type(v) == "table" then
      table.insert(ensure_installed, k)
    else
      table.insert(ensure_installed, v)
    end
  end

  for k, v in pairs(linters) do
    if type(v) == "table" then
      table.insert(ensure_installed, k)
    else
      table.insert(ensure_installed, v)
    end
  end

  for k, v in pairs(code_actions) do
    if type(v) == "table" then
      table.insert(ensure_installed, k)
    else
      table.insert(ensure_installed, v)
    end
  end

  require("mason-null-ls").setup({
    ensure_installed = ensure_installed,
    automatic_installation = true,
  })
end

function config.navigator()
  local on_attach = require("modules.lsp.handlers").on_attach
  local capabilities = require("modules.lsp.handlers").capabilities

  -- Create LspAttach autocmd
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('LspAttach', {}),
    callback = function(ev)
      local buf = ev.buf
      on_attach(ev.client, buf)
    end,
  })

  local nav_cfg = {
    debug = true,
    width = 0.75,
    height = 0.3,
    preview_height = 0.35,
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    -- ts_fold = {
    --   -- enable = false,
    --   comment_fold = true,
    --   max_lines_scan_comments = 20,
    --   disable_filetypes = { "help", "guihua", "text" },
    -- },
    default_mapping = false,
    treesitter_analysis = true,
    transparency = 50,
    capabilities = capabilities,

    lsp = {
      enable = true,
      code_action = { enable = false },
      code_lens_action = { enable = false },
      document_highlight = true,
      format_on_save = false,
      diagnostic = {
        underline = true,
        virtual_text = false,
        update_in_insert = false,
        severity_sort = { reverse = true },
      },
      disable_lsp = {
        "denols",
        "yamlls",
        "angularls",
        "jedi_language_server",
        "pylsp",
        "tsserver",
        "ruff_lsp",
        "texlab",
        "volar",
        "vue_ls",
      },
      disable_format_cap = { "stylua" },
      diagnostic_virtual_text = false,
      diagnostic_update_in_insert = false,
      disply_diagnostic_qf = true,
      vimls = {},
      emmet_ls = require("modules.lsp.settings.emmet_ls"),
      -- jsonls = require("modules.lsp.settings.jsonls"),
      pyright = require("modules.lsp.settings.pyright"),
      rust_analyzer = require("modules.lsp.settings.rust_analyzer"),
      solang = require("modules.lsp.settings.solang"),
      solc = require("modules.lsp.settings.solc"),
      lua_ls = require("modules.lsp.settings.lua_ls"),
      cssmodules_ls = { filetypes = { "css" } },
      dartls = { filetypes = { "dart" } },
      solargraph = { filetypes = { "ruby" } },
      -- yamlls = require("modules.lsp.settings.yamlls"),
      sqlls = require("modules.lsp.settings.sqlls"),
      cssls = { filetypes = { "css" } },
      html = require("modules.lsp.settings.html"),
      -- texlab = require("modules.lsp.settings.texlab"),
      bashls = { filetypes = { "bash", "sh" } },
      clangd = require("modules.lsp.settings.clangd"),
      ts_ls = require("modules.lsp.settings.tsserver"),
      tailwindcss = {
        filetypes = {
          "html",
          "css",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
        },
      },
      -- gopls = require("modules.lsp.settings.gopls"),
      jdtls = { filetypes = { "java" } },
      solidity_ls = { filetypes = { "solidity" }, install_server_name = "solidity" },
      r_language_server = { filetypes = { "r" } },
      lemminx = { filetypes = { "xml" } },
      marksman = { filetypes = { "markdown" } },
      zls = { filetypes = { "zig" } },
      ocamllsp = require("modules.lsp.settings.ocaml"),
    },
  }

  nav_cfg.lsp.gopls = function()
    if vim.tbl_contains({ "go", "gomod" }, vim.bo.filetype) then
      if pcall(require, "go") then
        return require("go.lsp").config()
      end
    end
  end

  require("navigator").setup(nav_cfg)
end

function config.lsp_singature()
  local icons = require("config.global").icons

  local signature_help_setup = {
    bind = true,
    noice = true,
    doc_lines = 10,

    max_height = 10,
    max_width = 80,

    wrap = true,
    fix_pos = false,

    floating_window = true,
    floating_window_above_cur_line = true,
    floating_window_off_x = 1,
    floating_window_off_y = 0,

    hint_enable = true,
    hi_parameter = "LspSignatureActiveParameter",

    toggle_key = "<C-s>",
    toggle_key_flip_floatwin_setting = true,
    -- select_signature_key = "<C-S>",

    hint_prefix = icons.misc.Squirrel .. " ",
    hint_scheme = "Comment",

    handler_opts = {
      border = "rounded",
    },
  }

  require("lsp_signature").setup(signature_help_setup)
end

function config.go()
  local setup = {
    -- fillstruct = "gopls",
    -- log_path = "/tmp/gonvim.log",
    -- lsp_codelens = false, -- use navigator
    -- lsp_gofumpt = true,
    -- dap_debug = true,
    -- gofmt = "gopls",
    -- goimports = "gopls",
    -- dap_debug_vt = true,
    -- dap_debug_gui = true,
    -- diagnostic = false,
    -- test_runner = "go",
    -- run_in_floaterm = true,
    -- lsp_document_formatting = true,
    -- preludes = {
    --   default = function()
    --     return { "AWS_PROFILE=test" }
    --   end,
    --   GoRun = function()
    --     local pwd = vim.fn.getcwd()
    --     local cmdl = { "watchexec", "--restart", "-v", "-e", "go" }
    --     -- if current folder contains sub folder with name pattern .\w+-env
    --     -- list all subfolders see if match .\w+-env
    --     local hasenv = false
    --     for _, v in ipairs(vim.fn.readdir(pwd)) do
    --       if string.match(v, "%p%a+%p*env") then
    --         hasenv = true
    --         break
    --       end
    --     end

    --     if hasenv then
    --       local cwdl = vim.split(pwd, "/")
    --       local cwd = cwdl[#cwdl]
    --       local cwdp = vim.split(cwd, "-")
    --       local cwdps = cwdp[#cwdp]
    --       return vim.list_extend(cmdl, { "awsenv", cwdps })
    --     end
    --     return {}
    --   end,
    -- },
  }

  require("go").setup(setup)
end

function config.flutter_tools()
  local line = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

  require("flutter-tools").setup({
    ui = { border = line },
    debugger = {
      enabled = false,
      run_via_dap = false,
      exception_breakpoints = {},
    },
    outline = { auto_open = false },
    decorations = {
      statusline = { device = true, app_version = true },
    },
    widget_guides = { enabled = true, debug = false },
    dev_log = { enabled = true, open_cmd = "tabedit" },
    lsp = {
      color = {
        enabled = false,
        -- enabled = true,
        -- background = true,
        -- virtual_text = false,
      },
      settings = {
        showTodos = true,
        renameFilesWithClasses = "always",
        updateImportsOnRename = true,
        completeFunctionCalls = true,
        lineLength = 100,
      },
    },
  })
end

function config.clangd_extensions()
  local setup = {
    server = {
      root_dir = function(...)
        return require("lspconfig.util").root_pattern(
          "compile_commands.json",
          "compile_flags.txt",
          "configure.ac",
          ".git"
        )(...)
      end,
      capabilities = {
        offsetEncoding = { "utf-16" },
      },
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
      },
      init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
      },
    },
    extensions = {
      inlay_hints = {
        inline = true,
      },
    },
  }

  require("clangd_extensions").setup({
    server = setup.server,
    extensions = setup.extensions,
  })
end

return config
