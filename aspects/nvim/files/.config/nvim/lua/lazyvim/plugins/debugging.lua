return {
  {
    "nvim-neotest/neotest",
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
          }),
          require("neotest-plenary"),
          require("neotest-vim-test")({
            ignore_file_types = { "vim", "lua" },
          }),
          require("neotest-jest")({
            jestCommand = "npm test --",
            jestConfigFile = "custom.jest.config.ts",
            env = { CI = true },
            cwd = function(_)
              return vim.fn.getcwd()
            end,
          }),
        },
      })
    end,
    dependencies = {
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-vim-test",
      "haydenmeade/neotest-jest",
    },
    -- event = "VeryLazy",
  },

  {
    "mfussenegger/nvim-dap",
    config = function()
      local icons = require("lazyvim.config.global").icons
      local dap = require("dap")
      local dapui = require("dapui")

      local setup = {
        breakpoint = {
          text = icons.ui.Bug,
          texthl = "DiagnosticSignError",
          linehl = "",
          numhl = "",
        },
        breakpoint_rejected = {
          text = icons.ui.Bug,
          texthl = "LspDiagnosticsSignHint",
          linehl = "",
          numhl = "",
        },
        stopped = {
          text = icons.ui.BoldRightArrow,
          texthl = "DiagnosticSignWarn",
          linehl = "Visual",
          numhl = "DiagnosticSignWarn",
        },
        ui = {
          auto_open = true,
        },
      }

      vim.fn.sign_define("DapBreakpoint", setup.breakpoint)
      vim.fn.sign_define("DapBreakpointRejected", setup.breakpoint_rejected)
      vim.fn.sign_define("DapStopped", setup.stopped)

      dapui.setup({
        expand_lines = true,
        icons = { expanded = "", collapsed = "", circular = "" },
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.33 },
              { id = "breakpoints", size = 0.17 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 0.33,
            position = "right",
          },
          {
            elements = {
              { id = "repl", size = 0.45 },
              { id = "console", size = 0.55 },
            },
            size = 0.27,
            position = "bottom",
          },
        },
        floating = {
          max_height = 0.9,
          max_width = 0.5,
          border = vim.g.border_chars,
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
      })

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
    end,
    dependencies = {
      "ravenxrz/DAPInstall.nvim",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",

      {
        "mfussenegger/nvim-dap-python",
        config = function()
          require("dap-python").setup("/usr/bin/python3")
        end,
        ft = "python",
      },
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
  },
}
