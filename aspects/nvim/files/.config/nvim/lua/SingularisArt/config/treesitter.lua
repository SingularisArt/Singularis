local enable = false
local langtree = false

local treesitter = function()
  local lines = vim.fn.line("$")
  if lines > 30000 then
    vim.cmd([[syntax manual]])
    return
  end

  if lines > 7000 then
    enable = false
    langtree = false
    vim.cmd([[syntax on]])
  else
    enable = true
    langtree = true
  end

  require("nvim-treesitter.configs").setup({
    highlight = {
      enable = enable,
      additional_vim_regex_highlighting = false,
      disable = { "elm" },
      use_languagetree = langtree,
      custom_captures = { todo = "Todo" },
    },
  })
end

local treesitter_obj = function()
  local lines = vim.fn.line("$")
  if lines > 30000 then
    return
  end

  require("nvim-treesitter.configs").setup({
    indent = { enable = true },
    context_commentstring = { enable = true, enable_autocmd = false },
    incremental_selection = {
      enable = enable,
      keymaps = {
        init_selection = "gnn",
        scope_incremental = "gnn",
        node_incremental = "<TAB>",
        node_decremental = "<S-TAB>",
      },
    },
    textobjects = {
      lsp_interop = {
        enable = enable,
        peek_definition_code = { ["DF"] = "@function.outer", ["CF"] = "@class.outer" },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
        goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
        goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
        goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
      },
      select = {
        enable = enable,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      swap = {
        enable = enable,
        swap_next = { ["<leader>a"] = "@parameter.inner" },
        swap_previous = { ["<leader>A"] = "@parameter.inner" },
      },
    },
    ensure_installed = "all",
  })
end

local treesitter_ref = function()
  if vim.fn.line("$") > 7000 then
    enable = false
  end

  require("nvim-treesitter.configs").setup({
    refactor = {
      highlight_definitions = { enable = enable },
      highlight_current_scope = { enable = false },
      smart_rename = {
        enable = false,
      },
      navigation = {
        enable = false,
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
  parser_config.sql = {
    install_info = {
      url = vim.fn.expand("$HOME") .. "/github/nvim-treesitter/tree-sitter-sql",
      files = { "src/parser.c" },
    },
    filetype = "sql",
    used_by = { "psql", "pgsql" },
  }
  parser_config.proto = {
    install_info = {
      url = vim.fn.expand("$HOME") .. "/github/nvim-treesitter/tree-sitter-proto",
      files = { "src/parser.c" },
    },
    filetype = "proto",
    used_by = { "proto" },
  }

  parser_config.norg = {
    install_info = {
      url = "https://github.com/nvim-neorg/tree-sitter-norg",
      files = { "src/parser.c", "src/scanner.cc" },
      branch = "main",
    },
  }
end

local textsubjects = function()
  require("nvim-treesitter.configs").setup({

    textsubjects = {
      enable = true,
      prev_selection = ",",
      keymaps = {
        [">"] = "textsubjects-smart",
        [";"] = "textsubjects-container-outer",
        ["i;"] = "textsubjects-container-inner",
      },
    },
  })
end

local treesitter_context = function(width)
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

local playground = function()
  local lines = vim.fn.line("$")
  if lines > 30000 then
    vim.cmd([[syntax manual]])
    return
  end

  if lines > 7000 then
    enable = false
    langtree = false
    vim.cmd([[syntax on]])
  else
    enable = true
    langtree = true
  end

  require("nvim-treesitter.configs").setup({
    playground = {
      enable = true,
      disable = {},
      updatetime = 25,
      persist_queries = false,
      keybindings = {
        toggle_query_editor = "o",
        toggle_hl_groups = "i",
        toggle_injected_languages = "t",
        toggle_anonymous_nodes = "a",
        toggle_language_display = "I",
        focus_language = "f",
        unfocus_language = "F",
        update = "R",
        goto_node = "<cr>",
        show_help = "?",
      },
    },
  })
end

local treesitter_rainbow = function()
  local lines = vim.fn.line("$")
  if lines > 30000 then
    vim.cmd([[syntax manual]])
    return
  end

  if lines > 7000 then
    enable = false
    langtree = false
    vim.cmd([[syntax on]])
  else
    enable = true
    langtree = true
  end

  require("nvim-treesitter.configs").setup({
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil,
    },
  })
end

return {
  treesitter = treesitter,
  treesitter_obj = treesitter_obj,
  treesitter_ref = treesitter_ref,
  textsubjects = textsubjects,
  context = treesitter_context,
  playground = playground,
  treesitter_rainbow = treesitter_rainbow,
}
