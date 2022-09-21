local Job = require("plenary.job")

local source = {}

source.new = function()
  local self = setmetatable({ cache = {} }, { __index = source })

  return self
end

source.complete = function(self, _, callback)
  local bufnr = vim.api.nvim_get_current_buf()

  -- This just makes sure that we only hit the GH API once per session.
  --
  -- You could remove this if you wanted, but this just makes it so we're
  -- good programming citizens.
  if not self.cache[bufnr] then
    Job:new({
      -- Uses `gh` executable to request the issues from the remote repository.
      "gh",
      "issue",
      "list",
      "--limit",
      "1000",
      "--json",
      "title,number,body",

      on_exit = function(job)
        local result = job:result()
        local ok, parsed = pcall(vim.json.decode, table.concat(result, ""))
        if not ok then
          vim.notify("Failed to parse gh result")
          return
        end

        local items = {}
        for _, gh_item in ipairs(parsed) do
          gh_item.body = string.gsub(gh_item.body or "", "\r", "")
t("<Plug>(ultisnips_jump_forward)"), "m", true)
          else
            if require("neogen").jumpable() then
              require("neogen").jump_next()
            else
              fallback()
            end
          end
        end,
        s = function(fallback)
          if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
            vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
          else
            fallback()
          end
        end,
      }),
      ["<C-k>"] = cmp.mapping({
        c = function()
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
          else
            cmp.complete()
          end
        end,
        i = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
          elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
            return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), "m", true)
          else
            if require("neogen").jumpable(true) then
              require("neogen").jump_prev()
            else
              fallback()
            end
          end
        end,
        s = function(fallback)
          if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
            return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), "m", true
