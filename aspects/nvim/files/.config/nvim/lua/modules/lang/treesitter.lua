local treesitter = function()
  local has_ts = pcall(require, "nvim-treesitter.configs")
  if not has_ts then
    vim.notify("ts not installed")
    return
  end

  require("nvim-treesitter.configs").setup({
    sync_install = false,
    modules = {},
    enable = true,
    use_languagetree = false,
    ensure_installed = {
      "python",
      "cpp",
      "c",
      -- "cs",
      "sql",
      "html",
      "css",
      "javascript",
      "typescript",
      "php",
      "ruby",
      "perl",
      "java",
      "rust",
      "solidity",
      "dockerfile",
      "kotlin",
      "ocaml",
      "zig",
      "markdown",
    },
    ignore_install = { "latex", "markdown" },
    additional_vim_regex_highlighting = { "latex" },
    auto_install = true,
  })
end

local treesitter_obj = function()
  local lines = vim.fn.line("$")
  if lines > 8000 then
    print("skip treesitter obj")
    return
  end
end

local treesitter_ref = function()
  require("nvim-treesitter.configs").setup({
    refactor = {
      highlight_definitions = { enable = true },
      highlight_current_scope = { enable = false },
      smart_rename = { enable = false },
      navigation = { enable = false },
    },
    matchup = {
      enable = true,
      disable_virtual_text = true,
    },
    autopairs = { enable = true },
    autotag = { enable = false },
  })

  vim.g.matchup_matchparen_enabled = 0
end

local function textsubjects()
  require("nvim-treesitter.configs").setup({
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",

          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",

          ["as"] = { query = "@scope", query_group = "locals" },
        },

        selection_modes = {
          ["@parameter.outer"] = "v",
          ["@function.outer"] = "V",
          ["@function.inner"] = "v",
          ["@class.outer"] = "<c-v>",
        },

        include_surrounding_whitespace = true,
      },

      swap = {
        enable = true,
        swap_next = { ["[n"] = "@parameter.inner" },
        swap_previous = { ["]n"] = "@parameter.inner" },
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
