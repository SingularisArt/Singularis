if vim.g.isLATEX or vim.g.isInkscape then
  return function(_use) end
end

local opts = require("config.global").opts
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
    keys = {
      { "<Leader>na", function() require('neotest').run.attach() end, desc = "Attach to the neartest test (Neotest)." },
      { "<Leader>nc", function() require('neotest').run.run(vim.fn.expand('%')) end, opts, "Run the current file (Neotest)." },
      { "<Leader>nd", function() require('neotest').run.run({ strategy = 'dap' }) end, opts, "Debug the nearest test (Neotest)." },
      { "<Leader>ne", function() require('neotest').output.open({ enter = true, auto_close = true }) end, opts, "Open the output of a test result (Neotest)." },
      { "<Leader>nj", function() require('neotest').jump.prev({ status = 'failed' }) end, opts, "Jump to next error (Neotest)." },
      { "<Leader>nk", function() require('neotest').jump.next({ status = 'failed' }) end, opts, "Jump to previous error (Neotest)." },
      { "<Leader>nn", function() require('neotest').run.run() end, opts, "Run the nearest test (Neotest)." },
      { "<Leader>ns", function() require('neotest').run.stop() end, opts, "Stop the nearest test (Neotest)." },
      { "<Leader>nS", function() require('neotest').summary.toggle() end, opts, "Toggle the summary window (Neotest)." },
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
      { "<Leader>na", function() require("neotest").run.attach() end, desc = "Attach to the neartest test (Neotest)." },
      { "<Leader>nc", function() require("neotest").run.run(vim.fn.expand("%")) end, opts, "Run the current file (Neotest)." },
      { "<Leader>nd", function() require("neotest").run.run({ strategy = "dap" }) end, opts, "Debug the nearest test (Neotest)." },
      { "<Leader>ne", function() require("neotest").output.open({ enter = true, auto_close = true }) end, opts, "Open the output of a test result (Neotest)." },
      { "<Leader>nj", function() require("neotest").jump.prev({ status = "failed" }) end, opts, "Jump to next error (Neotest)." },
      { "<Leader>nk", function() require("neotest").jump.next({ status = "failed" }) end, opts, "Jump to previous error (Neotest)." },
      { "<Leader>nn", function() require("neotest").run.run() end, opts, "Run the nearest test (Neotest)." },
      { "<Leader>ns", function() require("neotest").run.stop() end, opts, "Stop the nearest test (Neotest)." },
      { "<Leader>nS", function() require("neotest").summary.toggle() end, opts, "Toggle the summary window (Neotest)." },
    }
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
