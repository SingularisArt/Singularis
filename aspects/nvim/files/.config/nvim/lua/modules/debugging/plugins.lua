if vim.g.isInkscape then
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
        "sidlatau/neotest-dart", ft = { "dart" },
        config = function()
          require("neotest-dart") { command = "flutter" }
        end
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
      {
        "mfussenegger/nvim-dap-python",
        config = function()
          require("dap-python").setup("/usr/bin/python3")
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
            }
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
        end
      }
    },
    keys = {
      "<Leader>dt",
      "<Leader>db",
      "<Leader>dc",
      "<Leader>dC",
      "<Leader>dd",
      "<Leader>dg",
      "<Leader>di",
      "<Leader>do",
      "<Leader>du",
      "<Leader>dp",
      "<Leader>dr",
      "<Leader>ds",
      "<Leader>dq",
      "<Leader>dU",
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
