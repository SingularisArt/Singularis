require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.norg.concealer"] = {},
    ["core.norg.dirman"] = {
      config = { workspaces = { my_workspace = "~/neorg" } },
    },
    ["core.keybinds"] = {
      config = {
        default_keybinds = true,
        neorg_leader = "<Leader>o",
      },
    },
    ["core.norg.completion"] = { config = { engine = "nvim-cmp" } },
    ["core.integrations.telescope"] = {},
  },
})
local neorg_callbacks = require("neorg.callbacks")

neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
  keybinds.map_event_to_mode("norg", {
    n = {
      { "<C-s>", "core.integrations.telescope.find_linkable" },
    },

    i = {
      { "<C-l>", "core.integrations.telescope.insert_link" },
    },
  }, { silent = true, noremap = true })
end)
