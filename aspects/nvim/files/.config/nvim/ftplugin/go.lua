local which_key = require("which-key")
local options = require("config.global").which_key_vars.options

options = vim.tbl_deep_extend("force", {
  filetype = "lua",
  buffer = vim.api.nvim_get_current_buf(),
}, options)

which_key.add({
  { "<Leader>L", group = "Language" },
  { "<Leader>Lo", "<CMD>GoPkgOutline<CR>", desc = "Package Outline" },
  { "<Leader>LM", "<CMD>GoMockGen<CR>", desc = "Generate mocks for current file" },
  { "<Leader>LI", "<CMD>GoToggleInlay<CR>", desc = "Toggle inlay hints" },
  { "<Leader>Lr", "<CMD>GoGenReturn<CR>", desc = "Create return value for current function" },

  { "<Leader>LF", group = "Auto Fill" },
  { "<Leader>LFs", "<CMD>GoFillStruct<CR>", desc = "Auto fill struct" },
  { "<Leader>LFw", "<CMD>GoFillSwitch<CR>", desc = "Fill switch" },
  { "<Leader>LFe", "<CMD>GoIfErr<CR>", desc = "Add if err" },
  { "<Leader>LFp", "<CMD>GoFillPlurals<CR>", desc = "change func foo(b int, a int, r int) -> func foo(b, a, r int)" },

  { "<Leader>Li", group = "Install" },
  { "<Leader>Lii", "<CMD>GoInstallBinaries<CR>", desc = "Install all tools, skip the ones installed" },
  { "<Leader>Liu", "<CMD>GoUpdateBinaries<CR>", desc = "Update all tools to the latest version" },

  { "<Leader>Lb", group = "Build" },
  { "<Leader>Lbm", "<CMD>GoMake<CR>", desc = "Make" },
  { "<Leader>Lbg", "<CMD>GoBuild<CR>", desc = "Build" },
  { "<Leader>Lbr", "<CMD>GoGenerate<CR>", desc = "Generate" },
  { "<Leader>Lbs", "<CMD>GoStop<CR>", desc = "Stop job GoRun started" },

  { "<Leader>Lt", group = "Test" },
  { "<Leader>Ltt", "<CMD>GoTest<CR>", desc = "Test" },
  { "<Leader>Ltw", "<CMD>GoTestSum -w<CR>", desc = "Test in watch mode" },
  { "<Leader>Ltv", "<CMD>GoTest -v<CR>", desc = "Test -v current file path" },
  { "<Leader>Ltc", "<CMD>GoTest -c<CR>", desc = "Test -c current file path" },
  { "<Leader>Ltn", "<CMD>GoTest -n<CR>", desc = "Test nearest" },
  { "<Leader>Ltf", "<CMD>GoTest -f<CR>", desc = "Test current file" },
  { "<Leader>Ltp", "<CMD>GoTest -p<CR>", desc = "Test current package" },
  { "<Leader>Ltv", "<CMD>GoVet<CR>", desc = "Vet" },
  { "<Leader>LtC", "<CMD>GoCoverage<CR>", desc = "Test cover profile" },
  { "<Leader>LtP", "<CMD>GoCoverage -p<CR>", desc = "Test package for current buffer" },

  { "<Leader>LT", group = "Tags" },
  { "<Leader>LTa", "<CMD>GoAddTag<CR>", desc = "Add tag" },
  { "<Leader>LTr", "<CMD>GoRmTag<CR>", desc = "Remove tag" },
  { "<Leader>LTc", "<CMD>GoClearTag<CR>", desc = "Clear tag" },

  { "<Leader>Lf", group = "Format" },
  { "<Leader>Lff", "<CMD>GoFmt<CR>", desc = "Format" },
  { "<Leader>Lfi", "<CMD>GoImport<CR>", desc = "Import" },

  { "<Leader>Ls", group = "Switch between go and test file" },
  { "<Leader>Lsa", "<CMD>GoAlt!<CR>", desc = "Alternate file" },
  { "<Leader>Lss", "<CMD>GoAltS!<CR>", desc = "Alternate file (horizontal split)" },
  { "<Leader>Lsv", "<CMD>GoAltv!<CR>", desc = "Alternate file (vertical split)" },

  { "<Leader>Lm", group = "Mod" },
  { "<Leader>Lmi", "<CMD>GoModInit<CR>", desc = "Run go mod init" },
  { "<Leader>Lmt", "<CMD>GoModInit<CR>", desc = "Run go mod tidy" },
  { "<Leader>Lmv", "<CMD>GoModInit<CR>", desc = "Run go mod vendor" },

  { "<Leader>Lu", group = "Unit Tests" },
  { "<Leader>Luf", "<CMD><CR>", desc = "Run tests for current function" },
  { "<Leader>LuF", "<CMD><CR>", desc = "Run tests for current file" },
  { "<Leader>Lus", "<CMD><CR>", desc = "Select test function" },
  { "<Leader>Lup", "<CMD><CR>", desc = "Run tests for package" },
}, options)

-- local dap = require("dap")
-- dap.adapters.delve = {
--   type = "server",
--   port = "${port}",
--   executable = {
--     command = vim.fn.glob(os.getenv("HOME") .. "/.local/share/nvim/mason/packages/delve/dlv");
--     args = { "dap", "-l", "127.0.0.1:${port}" },
--   }
-- }

-- dap.configurations.go = {
--   {
--     type = "delve",
--     name = "Debug",
--     request = "launch",
--     program = "${file}"
--   },
--   {
--     type = "delve",
--     name = "Debug test",
--     request = "launch",
--     mode = "test",
--     program = "${file}"
--   },
--   {
--     type = "delve",
--     name = "Debug test (go.mod)",
--     request = "launch",
--     mode = "test",
--     program = "./${relativeFileDirname}"
--   }
-- }
