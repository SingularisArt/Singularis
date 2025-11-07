local which_key = require("which-key")
local options = require("config.global").which_key_vars.options

options = vim.tbl_deep_extend("force", {
  filetype = "dart",
  buffer = vim.api.nvim_get_current_buf(),
}, options)

which_key.add({
  { "<Leader>L", group = "Language" },
  { "<Leader>Lp", "<CMD>FlutterRun<CR>", desc = "Run project" },
  { "<Leader>Ld", "<CMD>FlutterDevices<CR>", desc = "List connected devices" },
  { "<Leader>Le", "<CMD>FlutterEmulators<CR>", desc = "List of emulators" },
  { "<Leader>Lq", "<CMD>FlutterQuit<CR>", desc = "End running session" },
  { "<Leader>LD", "<CMD>FlutterDetach<CR>", desc = "End running session locally" },
  { "<Leader>Lo", "<CMD>FlutterOutlineToggle<CR>", desc = "Toggle outline window" },
  { "<Leader>Lt", "<CMD>FlutterDevTools<CR>", desc = "Start Dart Dev Tools server" },
  { "<Leader>La", "<CMD>FlutterDevToolsActivate<CR>", desc = "Start Dart Dev Tools server" },
  { "<Leader>LP", "<CMD>FlutterCopyProfilerUrl<CR>", desc = "Copy profiler url to system clipboard" },
  { "<Leader>Ll", "<CMD>FlutterLspRestart<CR>", desc = "Restart LSP" },
  { "<Leader>Ls", "<CMD>FlutterSuper<CR>", desc = "Go to super class" },
  { "<Leader>Lr", "<CMD>FlutterRename<CR>", desc = "Rename and updates imports" },
}, options)

-- local dap = require("dap")
-- local mason_path = vim.fn.glob(vim.fn.stdpath("data")) .. "/mason/"
-- local dart_debug_adapter_exec_path = mason_path .. "packages/dart-debug-adapter"

-- dap.adapters.dart = {
--   type = "executable",
--   command = "node",
--   args = {dart_debug_adapter_exec_path .. "/extension/out/dist/debug.js", "flutter"}
-- }
-- dap.configurations.dart = {
--   {
--     type = "dart",
--     request = "launch",
--     name = "Launch flutter",
--     dartSdkPath = os.getenv("HOME") .. "/.config/flutter/bin/cache/dart-sdk/",
--     flutterSdkPath = os.getenv("HOME") .. "/.config/flutter",
--     program = "${workspaceFolder}/lib/main.dart",
--     cwd = "${workspaceFolder}",
--   }
-- }
