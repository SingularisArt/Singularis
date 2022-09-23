local neorg_callbacks = require("neorg.callbacks")
local neorg = require("neorg")

neorg.setup({
  load = {
    ["core.defaults"] = {}, -- Load all the default modules
    ["core.export"] = {},
    ["core.norg.completion"] = {
      config = {
        engine = "nvim-cmp",
      },
    },
    ["core.looking-glass"] = {}, -- Enable the looking_glass module
    ["core.export.markdown"] = {
      config = {
        extensions = "all",
      },
    },
    -- ["external.kanban"] = {},
    -- ["external.zettelkasten"] = {},
    -- ["external.context"] = {},
    ["core.norg.concealer"] = {
      config = {
        -- markup_preset = "dimmed",
        -- markup_preset = "conceal",
        icon_preset = "diamond",
        markup_preset = "varied",
        icons = {
          marker = {
            enabled = true,
            icon = " ",
          },
          todo = {
            enable = true,
            pending = {
              -- icon = ""
              icon = "",
            },
            uncertain = {
              icon = "?",
            },
            urgent = {
              icon = "",
            },
            on_hold = {
              icon = "",
            },
            cancelled = {
              icon = "",
            },
          },
          heading = {
            enabled = true,
            level_1 = {
              icon = "◈",
            },

            level_2 = {
              icon = " ◇",
            },

            level_3 = {
              icon = "  ◆",
            },
            level_4 = {
              icon = "   ❖",
            },
            level_5 = {
              icon = "    ⟡",
            },
            level_6 = {
              icon = "     ⋄",
            },
          },
        },
      },
    },
    ["core.presenter"] = {
      config = {
        zen_mode = "zen-mode",
        slide_count = {
          enable = true,
          position = "top",
          count_format = "[%d/%d]",
        },
      },
    },

    ["core.norg.esupports.metagen"] = {
      config = {
        type = "auto",
      },
    },

    ["core.keybinds"] = {
      config = {
        default_keybinds = true,
        neorg_leader = "<Leader>",
      },
    },

    ["core.norg.dirman"] = { -- Manage your directories with Neorg
      config = {
        workspaces = {
          home = "~/Documents/school-notes/notes",
          personal = "~/Documents/school-notes/personal",
          college = "~/Documents/school-notes/college",
        },
        index = "index.norg",
        --[[ autodetect = true,
                  autochdir = false, ]]
      },
    },

    ["core.norg.qol.toc"] = {
      config = {
        close_split_on_jump = false,
        toc_split_placement = "left",
      },
    },
    ["core.norg.journal"] = {
      config = {
        workspace = "home",
        journal_folder = "journal",
        use_folders = false,
      },
    },
  },
  logger = {
    level = "warn",
  },
})

local neorg_leader = "<Leader>"
neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
  -- Map all the below keybinds only when the "norg" mode is active
  keybinds.map_event_to_mode("norg", {
    n = {

      { "<Leader><CR>", "core.looking-glass.magnify-code-block" },

      -- Keys for managing TODO items and setting their states
      { "<Leader>ntu", "core.norg.qol.todo_items.todo.task_undone" },
      { "<Leader>ntp", "core.norg.qol.todo_items.todo.task_pending" },
      { "<Leader>ntd", "core.norg.qol.todo_items.todo.task_done" },
      { "<Leader>nth", "core.norg.qol.todo_items.todo.task_on_hold" },
      { "<Leader>ntc", "core.norg.qol.todo_items.todo.task_cancelled" },
      { "<Leader>ntr", "core.norg.qol.todo_items.todo.task_recurring" },
      { "<Leader>nti", "core.norg.qol.todo_items.todo.task_important" },
      { "<Leader>ntC", "core.norg.qol.todo_items.todo.task_cycle" },

      -- Keys for managing GTD
      { "<Leader>ngc", "core.gtd.base.capture" },
      { "<Leader>ngv", "core.gtd.base.views" },
      { "<Leader>nge", "core.gtd.base.edit" },

      -- Keys for managing notes
      { "<Leader>ndn", "core.norg.dirman.new.note" },

      { "<CR>", "core.norg.esupports.hop.hop-link" },
      { "<M-CR>", "core.norg.esupports.hop.hop-link", "vsplit" },

      { "<C-Shift>k", "core.norg.manoeuvre.item_up" },
      { "<C-Shift>j", "core.norg.manoeuvre.item_down" },
    },
  }, {
    silent = true,
    noremap = true,
  })

  -- Map the below keys only when traverse-heading mode is active
  keybinds.map_event_to_mode("traverse-heading", {
    n = {
      -- Rebind j and k to move between headings in traverse-heading mode
      { "j", "core.integrations.treesitter.next.heading" },
      { "k", "core.integrations.treesitter.previous.heading" },
    },
  }, {
    silent = true,
    noremap = true,
  })
  keybinds.map_event_to_mode("toc-split", {
    n = {
      { "<CR>", "core.norg.qol.toc.hop-toc-link" },

      -- Keys for closing the current display
      { "q", "core.norg.qol.toc.close" },
      { "<Esc>", "core.norg.qol.toc.close" },
    },
  }, {
    silent = true,
    noremap = true,
    nowait = true,
  })

  -- Map the below keys on gtd displays
  keybinds.map_event_to_mode("gtd-displays", {
    n = {
      { "<CR>", "core.gtd.ui.goto_task" },

      -- Keys for closing the current display
      { "q", "core.gtd.ui.close" },
      { "<Esc>", "core.gtd.ui.close" },

      { "e", "core.gtd.ui.edit_task" },
      { "<Tab>", "core.gtd.ui.details" },
    },
  }, {
    silent = true,
    noremap = true,
    nowait = true,
  })

  -- Map the below keys on presenter mode
  keybinds.map_event_to_mode("presenter", {
    n = {
      { "<CR>", "core.presenter.next_page" },
      { "l", "core.presenter.next_page" },
      { "h", "core.presenter.previous_page" },

      -- Keys for closing the current display
      { "q", "core.presenter.close" },
      { "<Esc>", "core.presenter.close" },
    },
  }, {
    silent = true,
    noremap = true,
    nowait = true,
  })
  -- Apply the below keys to all modes
  keybinds.map_to_mode("all", {
    n = {
      { neorg_leader .. "mn", ":Neorg mode norg<CR>" },
      { neorg_leader .. "mh", ":Neorg mode traverse-heading<CR>" },

      { neorg_leader .. "ze", ":Neorg zettel explore<CR>" },
      { neorg_leader .. "zn", ":Neorg zettel new<CR>" },
      { neorg_leader .. "zb", ":Neorg zettel backlinks<CR>" },

      {
        "<C-;>",
        ':lua require"telescope".extensions.neorg.search_headings({theme="ivy",border = true,shorten_path = false,prompt_prefix = " ◈  ",layout_config = {prompt_position = "top"}})<CR>',
      },
      {
        neorg_leader .. "u",
        ':lua require"telescope".extensions.neorg.find_context_tasks({theme="ivy",border = true,shorten_path = false,prompt_prefix = " ◈  ",layout_config = {prompt_position = "top"}})<CR>',
      },
      {
        neorg_leader .. "i",
        ':lua require"telescope".extensions.neorg.find_project_tasks({theme="ivy",border = true,shorten_path = false,prompt_prefix = " ◈  ",layout_config = {prompt_position = "top"}})<CR>',
      },
      {
        neorg_leader .. "o",
        ':lua require"telescope".extensions.neorg.find_aof_tasks({theme="ivy",border = true,shorten_path = false,prompt_prefix = " ◈  ",layout_config = {prompt_position = "top"}})<CR>',
      },
      {
        neorg_leader .. "p",
        ':lua require"telescope".extensions.neorg.find_aof_project_tasks({theme="ivy",border = true,shorten_path = false,prompt_prefix = " ◈  ",layout_config = {prompt_position = "top"}})<CR>',
      },
    },
  }, {
    silent = true,
    noremap = true,
  })
end)
