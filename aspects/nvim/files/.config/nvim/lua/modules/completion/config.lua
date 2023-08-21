local config = {}

function config.cmp()
  local cmp = require("cmp")
  local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
  local neogen_ok, neogen = pcall(require, "neogen")

  local icons = require("config.global").icons
  local kind_icons = icons.kind
  local duplicates = {
    buffer = 1,
    path = 1,
    nvim_lsp = 0,
  }

  local source_names = {
    nvim_lsp = "(LSP)",
    nvim_lua = "(Lua)",
    ultisnips = "(Snippets)",
    calc = "(Calc)",
    path = "(Path)",
    buffer = "(Buffer)",
    emoji = "(Emoji)",
    ["vim-dadbod-completion"] = "(SQL)",
    spell = "(Spell)",
    latex_symbols = "(LaTeX)",
    crates = "(Crates)",
    omni = "(Mail)",
    cmp_nvim_r = "(R)",
    cmp_zotcite = "(Zotero)",
  }

  local cmp_sources = {
    { name = "nvim_lsp" },
    { name = "ultisnips" },
    { name = "calc" },
    { name = "path" },
    { name = "buffer" },
    { name = "emoji" },
  }

  local function border(hl_name)
    return {
      { "╭", hl_name },
      { "─", hl_name },
      { "╮", hl_name },
      { "│", hl_name },
      { "╯", hl_name },
      { "─", hl_name },
      { "╰", hl_name },
      { "│", hl_name },
    }
  end

  ----------------------------
  --  Global Configuration  --
  ----------------------------

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
      ["<C-j>"] = cmp.mapping({
        i = function(fallback)
          cmp_ultisnips_mappings.compose({ "jump_forwards" })(function()
            if neogen_ok and neogen.jumpable() then
              neogen.jump_next()
            else
              fallback()
            end
          end)
        end,
      }),
      ["<C-k>"] = cmp.mapping({
        i = function(fallback)
          cmp_ultisnips_mappings.compose({ "jump_backwards" })(function()
            if neogen_ok and neogen.jumpable(true) then
              neogen.jump_prev()
            else
              fallback()
            end
          end)
        end,
      }),
    }),
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        vim_item.kind = kind_icons[vim_item.kind]
        vim_item.menu = source_names[entry.source.name]
        vim_item.dup = duplicates[entry.source.name]

        return vim_item
      end,
    },
    sources = cmp_sources,
    completion = {
      completeopt = "menu,menuone,noinsert",
      autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
      keyword_length = 1,
    },
    experimental = {
      ghost_text = true,
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    window = {
      completion = {
        border = border "CmpDocBorder",
        winhighlight = "Normal:CmpDoc",
      },
      documentation = {
        border = border "CmpDocBorder",
        winhighlight = "Normal:CmpDoc",
      },
    },
  })

  ------------------------------
  --  FileType Configuration  --
  ------------------------------

  cmp.setup.filetype("tex", {
    sources = cmp.config.sources({
      { name = "latex_symbols", option = { strategy = 2 } },
    }, cmp.get_config().sources),
  })

  cmp.setup.filetype({ "markdown", "tex" }, {
    sources = cmp.config.sources({
      { name = "spell" },
    }, cmp.get_config().sources),
  })

  cmp.setup.filetype("sql", {
    sources = cmp.config.sources({
      { name = "vim-dadbod-completion" },
    }, cmp.get_config().sources),
  })

  cmp.setup.filetype("lua", {
    sources = cmp.config.sources({
      { name = "nvim_lua" },
    }, cmp.get_config().sources),
  })

  cmp.setup.filetype("rust", {
    sources = cmp.config.sources({
      { name = "crates" },
    }, cmp.get_config().sources),
  })

  cmp.setup.filetype("elm", {
    sources = cmp.config.sources({
      { name = "omni" },
    }, cmp.get_config().sources),
  })

  cmp.setup.filetype({ "r", "rmd" }, {
    sources = cmp.config.sources({
      { name = "cmp_zotcite" },
      { name = "cmp_nvim_r" },
    }, cmp.get_config().sources),
  })

  cmp.setup.filetype("toml", {
    sources = cmp.config.sources({
      { name = "crates" },
    }, cmp.get_config().sources),
  })

  cmp.setup.filetype("java", {
    completion = {
      keyword_length = 2,
    },
  })
end

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

  lir.setup({
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
  })

  require("nvim-web-devicons").set_icon({
    lir_folder_icon = {
      icon = "",
      color = "#42A5F5",
      name = "LirFolderNode",
    },
  })
end

return config
