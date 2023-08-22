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

function config.markdown_preview()
  vim.g.mkdp_markdown_css = os.getenv("HOME") .. "/.config/nvim/misc/static/markdown-preview.css"
  vim.g.mkdp_highlight_css = os.getenv("HOME") .. "/.cache/wal/colors.css"
  vim.g.vim_markdown_conceal = 1
  vim.g.vim_markdown_math = 1
  vim.g.vim_markdown_conceal_code_blocks = 0
  vim.g.vim_markdown_strikethrough = 1
end

function config.vimtex()
  vim.g.vimtex_view_method = "zathura"
  vim.g.latex_view_general_viewer = "zathura"
  vim.g.vimtex_compiler_progname = "nvr"
  vim.g.vimtex_quickfix_enabled = 0
end

function config.magma()
  vim.g.magma_image_provider = "kitty"
  vim.g.magma_automatically_open_output = true
  vim.g.magma_wrap_output = false
  vim.g.magma_output_window_borders = false
  vim.g.magma_cell_highlight_group = "CursorLine"
  vim.g.magma_save_path = vim.fn.stdpath("data") .. "/magma"
end

function config.package_json()
  local icons = require("config.global").icons

  require("package-info").setup({
    colors = {
      up_to_date = "#3C4048",
      outdated = "#fc514e",
    },
    icons = {
      enable = true,
      style = {
        up_to_date = icons.ui.CheckSquare,
        outdated = icons.git.Remove,
      },
    },
    autostart = true,
    hide_up_to_date = true,
    hide_unstable_versions = true,
    package_manager = "npm",
  })
end

function config.dadbod()
  local function db_completion()
    require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
  end

  vim.g.db_ui_save_location = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. "db_ui"

  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "sql",
    },
    command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "sql",
      "mysql",
      "plsql",
    },
    callback = function()
      vim.schedule(db_completion)
    end,
  })
end

return config
