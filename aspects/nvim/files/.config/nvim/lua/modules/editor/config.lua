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
  local action_state = require("telescope.actions.state")
  local icons = require("config.global").icons

  -- Insert filename into the current buffer and keeping the insert mode.
  actions.insert_name_i = function(prompt_bufnr)
    local symbol = action_state.get_selected_entry().ordinal
    actions.close(prompt_bufnr)
    vim.schedule(function()
      vim.cmd([[startinsert]])
      vim.api.nvim_put({ symbol }, "", true, true)
    end)
  end

  -- Insert file path and name into the current buffer and keeping the insert mode.
  actions.insert_name_and_path_i = function(prompt_bufnr)
    local symbol = action_state.get_selected_entry().value
    actions.close(prompt_bufnr)
    vim.schedule(function()
      vim.cmd([[startinsert]])
      vim.api.nvim_put({ symbol }, "", true, true)
    end)
  end

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
          -- ["<C-h>"] = actions.which_key,
          -- ["<esc>"] = actions.close,
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

          -- ["?"] = actions.which_key,
        },
      },
    },
    pickers = {
      dotfiles = {
        theme = "dropdown",
      },
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

  require("telescope").load_extension("dotfiles")
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
            { "name", zindex = 10 },
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
            { "clipboard", zindex = 10 },
            { "bufnr", zindex = 10 },
            { "modified", zindex = 20, align = "right" },
            { "diagnostics", zindex = 20, align = "right" },
            { "git_status", zindex = 15, align = "right" },
          },
        },
      },
      message = {
        { "indent", with_markers = false },
        { "name", highlight = "NeoTreeMessage" },
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

return config
