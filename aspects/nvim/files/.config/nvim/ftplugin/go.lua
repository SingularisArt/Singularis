local which_key = require("which-key")
local options = require("config.global").which_key_vars.options

options = vim.tbl_deep_extend("force", {
  filetype = "lua",
  buffer = vim.api.nvim_get_current_buf(),
}, options)

which_key.register({
  ["L"] = {
    name = "Language",
    o = { "<CMD>GoPkgOutline<CR>", "Package Outline" },
    m = { "<CMD>GoMockGen<CR>", "Generate mocks for current file" },
    I = { "<CMD>GoToggleInlay<CR>", "Toggle inlay hints" },
    r = { "<CMD>GoGenReturn<CR>", "Create return value for current function" },
    f = {
      name = "Auto Fill",
      s = { "<CMD>GoFillStruct<CR>", "Auto fill struct" },
      w = { "<CMD>GoFillSwitch<CR>", "Fill switch" },
      e = { "<CMD>GoIfErr<CR>", "Add if err" },
      p = { "<CMD>GoFillPlurals<CR>", "change func foo(b int, a int, r int) -> func foo(b, a, r int)" },
    },
    i = {
      name = "Install",
      i = { "<CMD>GoInstallBinaries<CR>", "Install all tools, skip the ones installed" },
      u = { "<CMD>GoUpdateBinaries<CR>", "Update all tools to the latest version" },
    },
    b = {
      name = "Build",
      m = { "<CMD>GoMake<CR>", "Make" },
      g = { "<CMD>GoBuild<CR>", "Build" },
      r = { "<CMD>GoGenerate<CR>", "Generate" },
      s = { "<CMD>GoStop<CR>", "Stop job GoRun started" },
    },
    t = {
      name = "Test",
      t = { "<CMD>GoTest<CR>", "Test" },
      w = { "<CMD>GoTestSum -w<CR>", "Test in watch mode" },
      v = { "<CMD>GoTest -v<CR>", "Test -v current file path" },
      c = { "<CMD>GoTest -c<CR>", "Test -c current file path" },
      n = { "<CMD>GoTest -n<CR>", "Test nearest" },
      f = { "<CMD>GoTest -f<CR>", "Test current file" },
      p = { "<CMD>GoTest -p<CR>", "Test current package" },
      v = { "<CMD>GoVet<CR>", "Vet" },
      C = { "<CMD>GoCoverage<CR>", "Test cover profile" },
      P = { "<CMD>GoCoverage -p<CR>", "Test package for current buffer" },
    },
    T = {
      name = "Tags",
      a = { "<CMD>GoAddTag<CR>", "Add tag" },
      r = { "<CMD>GoRmTag<CR>", "Remove tag" },
      c = { "<CMD>GoClearTag<CR>", "Clear tag" },
    },
    f = {
      name = "Format",
      f = { "<CMD>GoFmt<CR>", "Format" },
      i = { "<CMD>GoImport<CR>", "Import" },
    },
    s = {
      name = "Switch between go and test file",
      a = { "<CMD>GoAlt!<CR>", "Alternate file" },
      s = { "<CMD>GoAltS!<CR>", "Alternate file (horizontal split)" },
      v = { "<CMD>GoAltv!<CR>", "Alternate file (vertical split)" },
    },
    m = {
      name = "Mod",
      i = { "<CMD>GoModInit<CR>", "Run go mod init" },
      t = { "<CMD>GoModInit<CR>", "Run go mod tidy" },
      v = { "<CMD>GoModInit<CR>", "Run go mod vendor" },
    },
    u = {
      name = "Unit Tests",
      f = { "<CMD><CR>", "Run tests for current function" },
      F = { "<CMD><CR>", "Run tests for current file" },
      s = { "<CMD><CR>", "Select test function" },
      p = { "<CMD><CR>", "Run tests for package" },
    },
  },
}, options)

local dap = require("dap")
dap.adapters.delve = {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fn.glob(os.getenv("HOME") .. "/.local/share/nvim/mason/packages/delve/dlv");
    args = { "dap", "-l", "127.0.0.1:${port}" },
  }
}

dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}"
  },
  {
    type = "delve",
    name = "Debug test",
    request = "launch",
    mode = "test",
    program = "${file}"
  },
  {
    type = "delve",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}"
  }
}
