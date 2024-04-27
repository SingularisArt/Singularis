local treesitter = function()
  local has_ts = pcall(require, "nvim-treesitter.configs")
  if not has_ts then
    vim.notify("ts not installed")
    return
  end

  require("nvim-treesitter.configs").setup({
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { "org" },
      disable = { "elm" },
      use_languagetree = false,
      custom_captures = { todo = "Todo" },
      auto_install = true,
      ensure_installed = {},
      ignore_install = { "latex", "markdown" },
    },
  })
end

local treesitter_obj = function()
  local lines = vim.fn.line("$")
  if lines > 8000 then
    print("skip treesitter obj")
    return
  end

  vim.g.skip_ts_context_commentstring_module = true

  require("ts_context_commentstring").setup({
    indent = { enable = true },
    context_commentstring = { enable = true },
    incremental_selection = {
      enable = false,
      keymaps = {
        init_selection = "gnn",
        scope_incremental = "gnn",
        node_incremental = "<TAB>",
        node_decremental = "<S-TAB>",
      },
    },
    textobjects = {
      keymaps = {
        ["."] = "textsubjects-smart",
        [";"] = "textsubjects-container-outer",
      },
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
      swap = {
        enable = true,
        swap_next = { ["[n"] = "@parameter.inner" },
        swap_previous = { ["]p"] = "@parameter.inner" },
      },
      lsp_interop = {
        enable = true,
        border = "rounded",
        peek_definition_code = {
          ["J"] = "@class.outer",
        },
      },
    },
  })
end

local treesitter_ref = function()
  require("nvim-treesitter.configs").setup({
    refactor = {
      highlight_definitions = { enable = true },
      highlight_current_scope = { enable = false },
      smart_rename = {
        enable = false,
      },
      navigation = {
        enable = true,
      },
    },
    matchup = {
      enable = true,
      disable = { "ruby" },
    },
    autopairs = { enable = true },
    autotag = { enable = true },
  })
  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  parser_config.norg = {
    install_info = {
      url = "https://github.com/nvim-neorg/tree-sitter-norg",
      files = { "src/parser.c", "src/scanner.cc" },
      branch = "main",
    },
  }
  parser_config.sql = {
    install_info = {
      url = "https://github.com/m-novikov/tree-sitter-sql",
      files = { "src/parser.c" },
      branch = "main",
    },
    filetype = { "sql", "psql" },
  }
end

local function textsubjects()
  require("nvim-treesitter.configs").setup({
    textsubjects = {
      enable = true,
      prev_selection = ",",
      keymaps = {
        ["."] = "textsubjects-smart",
        [";"] = "textsubjects-container-outer",
        ["i;"] = "textsubjects-container-inner",
      },
    },
  })
end

local function tshopper() end

local treesitter_context = function(width)
  local ok, ts = pcall(require, "nvim-treesitter")
  if not ok or not ts then
    return " "
  end
  local en_context = true

  local disable_ft = {
    "NvimTree",
    "neo-tree",
    "guihua",
    "packer",
    "guihua_rust",
    "clap_input",
    "clap_spinner",
    "TelescopePrompt",
    "csv",
    "txt",
    "defx",
  }

  local type_patterns = {
    "class",
    "function",
    "method",
    "interface",
    "type_spec",
    "table",
    "if_statement",
    "for_statement",
    "for_in_statement",
    "call_expression",
    "comment",
  }

  if vim.o.ft == "json" then
    type_patterns = { "object", "pair" }
  end
  if not en_context then
    return " "
  end

  local f = require("nvim-treesitter").statusline({
    indicator_size = width,
    type_patterns = type_patterns,
  })
  local context = string.format("%s", f)

  if context == "vim.NIL" then
    return " "
  end

  return " " .. context
end
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("SyntaxFtAuGroup", {}),
  callback = function()
    local fsize = vim.fn.getfsize(vim.fn.expand("%:p:f")) or 1
    if fsize < 100000 then
      vim.cmd("syntax on")
    end
  end,
})
return {
  treesitter = treesitter,
  treesitter_obj = treesitter_obj,
  treesitter_ref = treesitter_ref,
  textsubjects = textsubjects,
  context = treesitter_context,
  tshopper = tshopper,
}
