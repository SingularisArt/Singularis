local config = {}

function config.refactor()
  local refactor = require("refactoring")
  refactor.setup({})

  _G.ts_refactors = function()
    local function _refactor(prompt_bufnr)
      local content = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
      require("telescope.actions").close(prompt_bufnr)
      require("refactoring").refactor(content.value)
    end

    local opts = require("telescope.themes").get_cursor()
    require("telescope.pickers")
      .new(opts, {
        prompt_title = "refactors",
        finder = require("telescope.finders").new_table({
          results = require("refactoring").get_refactors(),
        }),
        sorter = require("telescope.config").values.generic_sorter(opts),
        attach_mappings = function(_, map)
          map("i", "<CR>", _refactor)
          map("n", "<CR>", _refactor)
          return true
        end,
      })
      :find()
  end
end

function config.outline()
  require("symbols-outline").setup({})
end

function config.syntax_folding()
  local fname = vim.fn.expand("%:p:f")
  local fsize = vim.fn.getfsize(fname)
  if fsize > 1024 * 1024 then
    print("disable syntax_folding")
    vim.api.nvim_command("setlocal foldmethod=indent")
    return
  end
  vim.api.nvim_command("setlocal foldmethod=expr")
  vim.api.nvim_command("setlocal foldexpr=nvim_treesitter#foldexpr()")
end

function config.regexplainer()
  require("regexplainer").setup({
    mode = "narrative",

    auto = false,

    filetypes = {
      "html",
      "js",
      "cjs",
      "mjs",
      "ts",
      "jsx",
      "tsx",
      "cjsx",
      "mjsx",
      "go",
      "lua",
      "vim",
    },

    mappings = {
      toggle = "<Leader>gR",
    },

    narrative = {
      separator = "\n",
    },
  })
end

local path = vim.split(package.path, ";")

table.insert(path, "lua/?.lua")
table.insert(path, "lua/?/init.lua")

function config.playground()
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

function config.luapad()
  require("luapad").setup({
    count_limit = 150000,
    error_indicator = true,
    eval_on_move = true,
    error_highlight = "WarningMsg",
    split_orientation = "horizontal",
    on_init = function()
      print("Luapad created!")
    end,
    context = {
      the_answer = 42,
      shout = function(str)
        return (string.upper(str) .. "!")
      end,
    },
  })
end
function config.ssr()
  require("ssr").setup({
    min_width = 50,
    min_height = 5,
    keymaps = {
      close = "q",
      next_match = "n",
      prev_match = "N",
      replace_all = "<leader><cr>",
    },
  })
end

function config.context_vt()
  require("nvim_context_vt").setup({
    enabled = true,

    disable_ft = { "markdown" },
    disable_virtual_lines = false,
    min_rows = 5,

    min_rows_ft = {},
    custom_parser = function(node, ft, opts)
      local utils = require("nvim_context_vt.utils")

      local start_row, _, end_row, _ = vim.treesitter.get_node_range(node)
      return string.format("-><%d:%d> %s", start_row + 1, end_row + 1, utils.get_node_text(node)[1])
    end,
  })
end

return config
