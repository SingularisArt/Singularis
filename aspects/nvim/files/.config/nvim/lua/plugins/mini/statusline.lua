local statusline = require("mini.statusline")

statusline.setup({
  content = {
    active = function()
      -- stylua: ignore start
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      local spell         = vim.wo.spell and (MiniStatusline.is_truncated(120) and "S" or "SPELL") or ""
      local wrap          = vim.wo.wrap and (MiniStatusline.is_truncated(120) and "W" or "WRAP") or ""
      local git           = MiniStatusline.section_git({ trunc_width = 75 })

      local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
      local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
      local searchcount   = MiniStatusline.section_searchcount({ trunc_width = 75 })
      local location      = MiniStatusline.section_location({ trunc_width = 75 })

      return MiniStatusline.combine_groups({
        { hl = mode_hl,                 strings = { mode, spell, wrap } },
        { hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
        "%<", -- Mark general truncate point
        { hl = "MiniStatuslineFilename", strings = { filename } },
        "%=", -- End left alignment
        { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
        { hl = mode_hl,                  strings = { searchcount, location } },
      })
    end,
  },
})
