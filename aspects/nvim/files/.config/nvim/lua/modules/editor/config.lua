local config = {}

function config.todo_comments()
  local todo_comments = require("todo-comments")

  local icons = require("config.global").icons

  local error_red = "#F44747"
  local warning_orange = "#ff8800"
  local hint_blue = "#4FC1FF"
  local perf_purple = "#7C3AED"
  local note_green = "#10B981"

  todo_comments.setup({
    signs = true,
    sign_priority = 8,
    keywords = {
      FIX = {
        icon = icons.ui.Bug,
        color = error_red,
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
      },
      TODO = { icon = icons.ui.Check, color = hint_blue, alt = { "TIP" } },
      HACK = { icon = icons.ui.Fire, color = warning_orange },
      WARN = { icon = icons.diagnostics.Warning, color = warning_orange, alt = { "WARNING", "XXX" } },
      PERF = {
        icon = icons.ui.Dashboard,
        color = perf_purple,
        alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE", "TEST" },
      },
      NOTE = { icon = icons.ui.Note, color = note_green, alt = { "INFO" } },
    },
    highlight = {
      before = "",
      keyword = "wide",
      after = "fg",
      pattern = [[.*<(KEYWORDS)\s*:]],
      comments_only = true,
      max_line_len = 400,
      exclude = { "markdown" },
    },
    search = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
      pattern = [[\b(KEYWORDS):]],
    },
  })
end

function config.telescope()
  local telescope = require("telescope")

  local actions = require("telescope.actions")
  local icons = require("config.global").icons

  telescope.setup({
    defaults = {
      prompt_prefix = icons.ui.Telescope .. " ",
      selection_caret = " ",
      path_display = { "smart" },
      file_ignore_patterns = {
        ".git/",
        "target/",
        "docs/",
        "vendor/*",
        "%.lock",
        "__pycache__/*",
        "%.sqlite3",
        "%.ipynb",
        "node_modules/*",
        "%.svg",
        "%.otf",
        "%.ttf",
        "%.webp",
        ".dart_tool/",
        ".github/",
        ".gradle/",
        ".idea/",
        ".settings/",
        ".vscode/",
        "__pycache__/",
        "build/",
        "env/",
        "gradle/",
        "node_modules/",
        "%.pdb",
        "%.dll",
        "%.class",
        "%.exe",
        "%.cache",
        "%.ico",
        "%.pdf",
        "%.dylib",
        "%.jar",
        "%.docx",
        "%.met",
        "smalljre_*/*",
        ".vale/",
        "%.burp",
        "%.mp4",
        "%.mkv",
        "%.rar",
        "%.zip",
        "%.7z",
        "%.tar",
        "%.bz2",
        "%.epub",
        "%.flac",
        "%.tar.gz",
      },

      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,

          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,

          ["<C-b>"] = actions.results_scrolling_up,
          ["<C-f>"] = actions.results_scrolling_down,

          ["<C-c>"] = actions.close,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,

          ["<CR>"] = actions.select_default,
          ["<C-s>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<c-d>"] = require("telescope.actions").delete_buffer,

          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          ["<C-l>"] = actions.complete_tag,
          ["<C-h>"] = actions.which_key,
          ["<esc>"] = actions.close,
        },

        n = {
          ["<esc>"] = actions.close,
          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,
          ["<C-b>"] = actions.results_scrolling_up,
          ["<C-f>"] = actions.results_scrolling_down,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["H"] = actions.move_to_top,
          ["M"] = actions.move_to_middle,
          ["L"] = actions.move_to_bottom,
          ["q"] = actions.close,
          ["dd"] = require("telescope.actions").delete_buffer,
          ["s"] = actions.select_horizontal,
          ["v"] = actions.select_vertical,
          ["t"] = actions.select_tab,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["gg"] = actions.move_to_top,
          ["G"] = actions.move_to_bottom,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,

          ["?"] = actions.which_key,
        },
      },
    },
    pickers = {
      live_grep = {
        theme = "dropdown",
      },
      grep_string = {
        theme = "dropdown",
      },
      find_files = {
        theme = "dropdown",
      },
      buffers = {
        theme = "dropdown",
      },
      lsp_references = {
        theme = "dropdown",
      },
      lsp_definitions = {
        theme = "dropdown",
      },
      lsp_declarations = {
        theme = "dropdown",
      },
      lsp_implementations = {
        theme = "dropdown",
      },
    },
    extensions = {},
  })
end

function config.telescope_sessions()
  local setup = {
    extensions = {
      sessions = {
        sessions = {
          sessions_path = os.getenv("HOME") .. "/.config/nvim/misc/sessions/",
          sessions_variable = "session",
        },
        dressing = true,
        autoload = false,
        autosave = true,
        autoswitch = {
          enable = false,
          exclude_ft = { "fugitive", "alpha", "NvimTree", "fzf", "qf" },
        },
        post_hook = nil,
      },
    },
  }

  require("telescope").setup(setup)
  require("telescope").load_extension("sessions")
end

function config.cybu()
  local cybu = require("cybu")

  cybu.setup({
    position = {
      relative_to = "win",
      anchor = "topright",
    },
    display_time = 1750,
    style = {
      path = "relative",
      border = "rounded",
      separator = " ",
      prefix = "…",
      padding = 1,
      hide_buffer_id = true,
      devicons = {
        enabled = true,
        colored = true,
      },
    },
  })

  vim.keymap.set("n", "H", "<Plug>(CybuPrev)")
  vim.keymap.set("n", "L", "<Plug>(CybuNext)")
end

function config.statuscol()
  local builtin = require("statuscol.builtin")
  require("statuscol").setup({
    relculright = false,
    ft_ignore = { "neo-tree" },
    segments = {
      {
        text = { " ", builtin.lnumfunc },
        condition = { true, builtin.not_empty },
        click = "v:lua.ScLa",
      },
      { text = { "%s" }, click = "v:lua.ScSa" },
      { text = { "%C", " " }, click = "v:lua.ScFa" },
    },
  })
  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    callback = function()
      if vim.bo.filetype == "neo-tree" then
        vim.opt_local.statuscolumn = ""
      end
    end,
  })
end

function config.neo_tree()
  local neotree = require("neo-tree")
  local icons = require("config.global").icons

  neotree.setup({
    close_if_last_window = true,
    enable_git_status = true,
    enable_diagnostics = true,
    sources = {
      "filesystem",
      "buffers",
      "git_status",
    },
    source_selector = {
      winbar = true,
      statusline = false,
      content_layout = "center",
      tabs_layout = "equal",
    },
    default_component_configs = {
      container = {
        enable_character_fade = true,
      },
      indent = {
        indent_size = 2,
        padding = 1,
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        highlight = "NeoTreeIndentMarker",
        with_expanders = false,
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
        default = " ",
        highlight = "NeoTreeFileIcon",
      },
      modified = {
        symbol = "[+]",
        highlight = "NeoTreeModified",
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
      },
      git_status = {
        symbols = {
          added = icons.git.added,
          modified = icons.git.modified,
          deleted = icons.git.removed,
          renamed = "",
          untracked = "",
          ignored = "",
          unstaged = "U",
          staged = "",
          conflict = "",
        },
      },
      diagnostics = {
        symbols = {
          hint = icons.diagnostics.Hint,
          info = icons.diagnostics.Info,
          warn = icons.diagnostics.Warn,
          error = icons.diagnostics.Error,
        },
        highlights = {
          hint = "DiagnosticSignHint",
          info = "DiagnosticSignInfo",
          warn = "DiagnosticSignWarn",
          error = "DiagnosticSignError",
        },
      },
    },
    window = {
      position = "left",
      width = 40,
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ["<space>"] = {
          "toggle_node",
          nowait = false,
        },
        ["<1-LeftMouse>"] = "open",
        ["<CR>"] = "open",
        ["l"] = "open",
        ["S"] = "open_split",
        ["s"] = "open_vsplit",
        ["t"] = "open_tabnew",
        ["w"] = "open_with_window_picker",
        ["C"] = "close_node",
        ["a"] = {
          "add",
          config = {
            show_path = "none",
          },
        },
        ["A"] = "add_directory",
        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["c"] = "copy",
        ["m"] = "move",
        ["q"] = "close_window",
        ["R"] = "refresh",
        ["?"] = "show_help",
      },
    },
    nesting_rules = {},
    filesystem = {
      bind_to_cwd = true,
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {},
        hide_by_pattern = {},
        never_show = {},
      },
      follow_current_file = true,
      group_empty_dirs = false,
      hijack_netrw_behavior = "open_default",
      use_libuv_file_watcher = true,
      window = {
        mappings = {
          ["H"] = "navigate_up",
          ["<bs>"] = "toggle_hidden",
          ["."] = "set_root",
          ["/"] = "fuzzy_finder",
          ["f"] = "filter_on_submit",
          ["<c-x>"] = "clear_filter",
          ["[g"] = "prev_git_modified",
          ["]g"] = "next_git_modified",
        },
      },
    },
    buffers = {
      follow_current_file = true,

      group_empty_dirs = true,
      show_unloaded = true,
      window = {
        mappings = {
          ["bd"] = "buffer_delete",
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
        },
      },
    },
    git_status = {
      window = {
        position = "float",
        mappings = {
          ["A"] = "git_add_all",
          ["gu"] = "git_unstage_file",
          ["ga"] = "git_add_file",
          ["gr"] = "git_revert_file",
          ["gc"] = "git_commit",
          ["gp"] = "git_push",
          ["gg"] = "git_commit_and_push",
        },
      },
    },
    renderers = {
      directory = {
        { "indent" },
        { "icon" },
        { "current_filter" },
        {
          "container",
          content = {
            { "name",      zindex = 10 },
            {
              "symlink_target",
              zindex = 10,
              highlight = "NeoTreeSymbolicLinkTarget",
            },
            { "clipboard", zindex = 10 },
            {
              "diagnostics",
              errors_only = true,
              zindex = 20,
              align = "right",
              hide_when_expanded = false,
            },
            {
              "git_status",
              zindex = 10,
              align = "right",
              hide_when_expanded = true,
            },
          },
        },
      },
      file = {
        { "indent" },
        { "icon" },
        {
          "container",
          content = {
            { "name", zindex = 10 },
            { "clipboard",   zindex = 10 },
            { "bufnr",       zindex = 10 },
            { "modified",    zindex = 20, align = "right" },
            { "diagnostics", zindex = 20, align = "right" },
            { "git_status",  zindex = 15, align = "right" },
          },
        },
      },
      message = {
        { "indent", with_markers = false },
        { "name",   highlight = "NeoTreeMessage" },
      },
      terminal = {
        { "indent" },
        { "icon" },
        { "name" },
        { "bufnr" },
      },
    },
  })
end

function config.lir()
  local lir = require("lir")

  local actions = require("lir.actions")
  local mark_actions = require("lir.mark.actions")
  local clipboard_actions = require("lir.clipboard.actions")
  local setup = {
    show_hidden_files = false,
    devicons = { enable = true },
    mappings = {
      ["<CR>"] = actions.edit,
      ["l"] = actions.edit,
      ["<C-s>"] = actions.split,
      ["v"] = actions.vsplit,
      ["<C-t>"] = actions.tabedit,
      ["h"] = actions.up,
      ["q"] = actions.quit,
      ["A"] = actions.mkdir,
      ["a"] = actions.newfile,
      ["r"] = actions.rename,
      ["@"] = actions.cd,
      ["Y"] = actions.yank_path,
      ["i"] = actions.toggle_show_hidden,
      ["d"] = actions.delete,
      ["J"] = function()
        mark_actions.toggle_mark()
        vim.cmd("normal! j")
      end,
      ["c"] = clipboard_actions.copy,
      ["x"] = clipboard_actions.cut,
      ["p"] = clipboard_actions.paste,
    },
    float = {
      winblend = 0,
      curdir_window = {
        enable = false,
        highlight_dirname = true,
      },

      win_opts = function()
        local width = math.floor(vim.o.columns * 0.7)
        local height = math.floor(vim.o.lines * 0.7)
        return {
          border = "rounded",
          width = width,
          height = height,
        }
      end,
    },
    hide_cursor = false,
    on_init = function()
      vim.api.nvim_buf_set_keymap(
        0,
        "x",
        "J",
        ":<C-u>lua require('lir.mark.actions').toggle_mark('v')<CR>",
        { noremap = true, silent = true }
      )
    end,
  }

  lir.setup(setup)

  require("nvim-web-devicons").set_icon({
    lir_folder_icon = {
      icon = "",
      color = "#42A5F5",
      name = "LirFolderNode",
    },
  })
end

return config
