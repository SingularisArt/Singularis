local conf = require("modules.lang.config")
local ts = require("modules.lang.treesitter")

return function(use)
  use({ "nvim-treesitter/nvim-treesitter", config = ts.treesitter, module = false })

  use({
    "HiPhish/nvim-ts-rainbow2",
    module = false,
    config = function()
      local fsize = vim.fn.getfsize(vim.fn.expand("%:p:f"))

      local enable = true
      if vim.fn.line("$") > 3000 or fsize > 100000 then
        enable = false
        return
      end

      require("nvim-treesitter.configs").setup({
        rainbow = { enable = enable, extended_mode = enable },
      })
    end,
  })

  use({
    "nvim-treesitter/nvim-treesitter-refactor",
    config = ts.treesitter_ref,
  })

  use({
    "nvim-treesitter/nvim-treesitter-textobjects",
    config = ts.treesitter_obj,
    module = false,
  })

  use({
    "RRethy/nvim-treesitter-textsubjects",
    config = ts.textsubjects,
    module = false,
  })

  use({
    "nvim-treesitter/nvim-treesitter-context",
    module = false,
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 2,
        trim_scope = "outer",
        mode = "topline",
        patterns = {
          default = {
            "class",
            "function",
            "method",
            "for",
            "while",
            "if",
            "switch",
          },
        },
      })
    end,
  })

  use({
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
    config = conf.playground,
  })

  use({ "JoosepAlviste/nvim-ts-context-commentstring" })

  use({ "windwp/nvim-ts-autotag" })

  use({
    "mfussenegger/nvim-treehopper",
    config = ts.tshopper,
    module = false
  })

  use({
    "bennypowers/nvim-regexplainer",
    cmd = { "RegexplainerToggle", "RegexplainerShow" },
    config = conf.regexplainer,
  })

  use({
    "haringsrob/nvim_context_vt",
    event = { "CursorHold", "WinScrolled", "CursorMoved" },
    config = conf.context_vt

  })
  use({ "ThePrimeagen/refactoring.nvim", config = conf.refactor })

  use({ "yardnsm/vim-import-cost", cmd = "ImportCost" })

  use({
    "rafcamlet/nvim-luapad",
    cmd = { "Lua", "Luapad" },
    config = conf.luapad,
  })

  use({ "mtdl9/vim-log-highlighting", ft = { "text", "txt", "log" } })

  local cmd = "bash install.sh"
  if require("config.global").is_windows then
    if vim.fn.executable("bash") == 0 then
      cmd = [[echo "failed to install sniprun, bash is not installed"]]
    end
  end

  use({
    "michaelb/sniprun",
    build = cmd,
    cmd = { "SnipRun", "SnipReset" },
    config = function()
      require("sniprun").setup({
        inline_messages = 1,
      })
    end,
  })

  use({ "gennaro-tedesco/nvim-jqx", cmd = { "JqxList", "JqxQuery" } })

  use({
    "bfrg/vim-jqplay",
    ft = "jq",
    cmd = { "Jqplay", "JqplayScratch", "JqplayScratchNoInput" },
  })

  use({
    "m-demare/hlargs.nvim",
    config = function()
      require("hlargs").setup({
        disable = function()
          local excluded_filetype = {
            "TelescopePrompt",
            "guihua",
            "guihua_rust",
            "clap_input",
            "lua",
            "rust",
            "typescript",
            "typescriptreact",
            "javascript",
            "javascriptreact",
          }
          if vim.tbl_contains(excluded_filetype, vim.bo.filetype) then
            return true
          end

          local bufnr = vim.api.nvim_get_current_buf()
          local filetype = vim.fn.getbufvar(bufnr, "&filetype")
          if filetype == "" then
            return true
          end
          local parsers = require("nvim-treesitter.parsers")
          local buflang = parsers.ft_to_use(filetype)
          return vim.tbl_contains(excluded_filetype, buflang)
        end,
      })
    end,
  })

  use({ "cshuaimin/ssr.nvim", config = conf.ssr })

  use({
    "HiPhish/awk-ward.nvim",
    ft = "awk",
    cmd = { "AwkWard" },
  })
  use({
    "mechatroner/rainbow_csv",
    ft = { "csv", "tsv", "dat" },
    cmd = { "RainbowDelim", "RainbowMultiDelim", "Select", "CSVLint" },
  })
end
