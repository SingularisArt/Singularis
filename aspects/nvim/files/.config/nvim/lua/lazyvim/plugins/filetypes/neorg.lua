local neorg_callbacks = require("neorg.callbacks")

require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.export"] = {},
    ["core.looking-glass"] = {},
    ["core.export.markdown"] = {},
    ["core.norg.concealer"] = {},
    ["core.integrations.telescope"] = {},
    -- ["core.gtd.ui"] = {},
    -- ["core.gtd.helpers"] = {},
    -- ["core.gtd.queries"] = {},

    ["core.norg.completion"] = {
      config = {
        engine = "nvim-cmp",
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
        neorg_leader = "<Space>",
      },
    },

    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          home = "~/Documents/school-notes/notes",
          personal = "~/Documents/school-notes/personal",
          college = "~/Documents/school-notes/college",
          ["current-course"] = "~/Documents/school-notes/current-course",
        },
        index = "index.norg",
      },
    },

    ["core.norg.qol.toc"] = {
      config = {
        close_split_on_jump = false,
        toc_split_placement = "left",
      },
    },
  },
})

neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
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
end)
