if vim.g.isLATEX or vim.g.isInkscape then
  return function(_use) end
end

local conf = require("modules.debugging.config")

return function(use)
  use({
    "nvim-neotest/neotest",
    config = conf.neotest,
    dependencies = {
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-vim-test",
      "haydenmeade/neotest-jest",
      {
        "sidlatau/neotest-dart",
        ft = { "dart" },
        config = function()
          require("neotest-dart")({ command = "flutter" })
        end,
      },
    },
  })

  use({
    "puremourning/vimspector",
    cmd = { "VimspectorInstall", "VimspectorUpdate" },
  })

  use({
    "mfussenegger/nvim-dap",
    config = conf.nvim_dap,
    dependencies = {
      "ravenxrz/DAPInstall.nvim",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      {
        "mfussenegger/nvim-dap-python",
        config = function()
          require("dap-python").setup("/usr/bin/python")
        end,
      },
      {
        "jbyuki/one-small-step-for-vimkind",
        config = function()
          local dap = require("dap")
          dap.configurations.lua = {
            {
              type = "nlua",
              request = "attach",
              name = "Attach to running Neovim instance",
            },
          }

          dap.adapters.nlua = function(callback, config)
            callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
          end
        end,
      },
      {
        "jay-babu/mason-nvim-dap.nvim",
        after = "mason.nvim",
        config = function()
          local config = require("modules.lsp.lsp_config")
          local ensure_installed = config.dap

          require("mason-nvim-dap").setup({
            ensure_installed = ensure_installed,
            automatic_installation = true,
          })
        end,
      },
    },
    keys = {
      { "<Leader>dt", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<Leader>db", function() require("dap").step_back() end, desc = "Step Back" },
      { "<Leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<Leader>dC", function() require("dap").run_to_cursor() end, desc = "Run To Cursor" },
      { "<Leader>dd", function() require("dap").disconnect() end, desc = "Disconnect" },
      { "<Leader>dg", function() require("dap").session() end, desc = "Get Session" },
      { "<Leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<Leader>do", function() require("dap").step_over() end, desc = "Step Over" },
      { "<Leader>du", function() require("dap").step_out() end, desc = "Step Out" },
      { "<Leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<Leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle Repl" },
      { "<Leader>ds", function() require("dap").continue() end, desc = "Start" },
      { "<Leader>dq", function() require("dap").close() end, desc = "Quit" },
      { "<Leader>dU", function() require("dapui").toggle() end, desc = "Enable/Disable UI" },
    },
  })

  use({
    "rcarriga/vim-ultest",
    dependencies = { "vim-test/vim-test" },
    cmd = {
      "TestNearest",
      "TestFile",
      "TestSuite",
      "TestLast",
      "TestVisit",
      "Ultest",
      "UltestNearest",
      "UltestDebug",
      "UltestLast",
      "UltestSummary",
    },
    config = function()
      require("config.test").setup()
    end,
  })
end
