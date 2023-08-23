local which_key = require("which-key")
local options = require("config.global").which_key_vars.options

options = vim.tbl_deep_extend("force", {
  filetype = "dart",
  buffer = vim.api.nvim_get_current_buf(),
}, options)

which_key.register({
  ["L"] = {
    name = "Language",
    p = { "<CMD>FlutterRun<CR>", "Run project" },
    d = { "<CMD>FlutterDevices<CR>", "List connected devices" },
    e = { "<CMD>FlutterEmulators<CR>", "List of emulators" },
    q = { "<CMD>FlutterQuit<CR>", "End running session" },
    D = { "<CMD>FlutterDetach<CR>", "End running session locally" },
    o = { "<CMD>FlutterOutlineToggle<CR>", "Toggle outline window" },
    t = { "<CMD>FlutterDevTools<CR>", "Start Dart Dev Tools server" },
    a = { "<CMD>FlutterDevToolsActivate<CR>", "Start Dart Dev Tools server" },
    P = { "<CMD>FlutterCopyProfilerUrl<CR>", "Copy profiler url to system clipboard" },
    l = { "<CMD>FlutterLspRestart<CR>", "Restart LSP" },
    s = { "<CMD>FlutterSuper<CR>", "Go to super class" },
    r = { "<CMD>FlutterRename<CR>", "Rename and updates imports" },
  },
}, options)

local dap = require("dap")
local mason_path = vim.fn.glob(vim.fn.stdpath("data")) .. "/mason/"
local dart_debug_adapter_exec_path = mason_path .. "packages/dart-debug-adapter"

dap.adapters.dart = {
  type = "executable",
  command = "node",
  args = {dart_debug_adapter_exec_path .. "/extension/out/dist/debug.js", "flutter"}
}
dap.configurations.dart = {
  {
    type = "dart",
    request = "launch",
    name = "Launch flutter",
    dartSdkPath = os.getenv("HOME") .. "/.config/flutter/bin/cache/dart-sdk/",
    flutterSdkPath = os.getenv("HOME") .. "/.config/flutter",
    program = "${workspaceFolder}/lib/main.dart",
    cwd = "${workspaceFolder}",
  }
}
