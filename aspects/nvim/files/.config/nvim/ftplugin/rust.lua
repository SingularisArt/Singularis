local which_key = require("which-key")
local options = SingularisArt.which_key.opts

options = vim.tbl_deep_extend("force", {
  filetype = "rust",
  buffer = vim.api.nvim_get_current_buf(),
}, options)

which_key.register({
  ["L"] = {
    name = "Language",
    r = { "<cmd>RustRunnables<CR>", "Runnables" },
    t = { "<cmd>lua _CARGO_TEST()<CR>", "Cargo Test" },
    m = { "<cmd>RustExpandMacro<CR>", "Expand Macro" },
    c = { "<cmd>RustOpenCargo<CR>", "Open Cargo" },
    p = { "<cmd>RustParentModule<CR>", "Parent Module" },
    d = { "<cmd>RustDebuggables<CR>", "Debuggables" },
    v = { "<cmd>RustViewCrateGraph<CR>", "View Crate Graph" },
    R = {
      "<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<CR>",
      "Reload Workspace",
    },
    o = { "<cmd>RustOpenExternalDocs<CR>", "Open External Docs" },
  },
}, options)
