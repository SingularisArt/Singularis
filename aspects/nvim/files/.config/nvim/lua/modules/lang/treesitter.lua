local langtree = false

local treesitter = function()
  local enable = false
  local has_ts = pcall(require, "nvim-treesitter.configs")
  if not has_ts then
    vim.notify("ts not installed")
    return
  end
  local lines = vim.fn.line("$")
  if lines > 20000 then
    vim.cmd([[syntax manual]])
    print("skip treesitter")
    return
  end

  if lines > 10000 then
    enable = true
    langtree = false
    vim.cmd([[syntax on]])
  else
    enable = true
    langtree = true
  end

  require("nvim-treesitter.configs").setup({
    highlight = {
      enable = enable,
      additional_vim_regex_highlighting = { "org" },
      disable = { "elm" },
      use_languagetree = langtree,
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

  local enable = true
  if lines > 4000 then
    enable = false
  end

  require("nvim-treesitter.configs").setup({
    indent = { enable = enable },
    context_commentstring = { enable = enable },
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
        }
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer"
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer"
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer"
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer"
        }
      },
      swap = {
        enable = true,
        swap_next = {["[n"] = "@parameter.inner"},
        swap_previous = {["]p"] = "@parameter.inner"}
      },
      lsp_interop = {
        enable = true,
        border = "rounded",
        peek_definition_code = {
          ["<Leader>ldp"] = "@class.outer"
        }
      },
    }
  })
end

local treesitter_ref = function()
  local enable
  if vim.fn.line("$") > 5000 then
    enable = false
  else
    enable = true
  end

  require("nvim-treesitter.configs").setup({
    refactor = {
      highlight_definitions = { enable = enable },
      highlight_current_scope = { enable = false },
      smart_rename = {
        enable = false,
      },
      navigation = {
        enable = true,
      },
    },
    matchup = {
      enable = enable,
      disable = { "ruby" },
    },
    autopairs = { enable = enable },
    autotag = { enable = enable },
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
  local enable = true
  if vim.fn.line("$") > 5000 then
    enable = false
  end
  require("nvim-treesitter.configs").setup({
    textsubjects = {
      enable = enable,
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

  if vim.fn.line("$") > 5000 then
    return " "
  end
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
  if vim.tbl_contains(disable_ft, vim.o.ft) then
    return " "
  end
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
