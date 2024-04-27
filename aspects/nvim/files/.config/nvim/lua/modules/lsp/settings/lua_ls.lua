return {
  settings = {
    Lua = {
      diagnostics = {
        globals = {
          "vim",
        },
      },
      completion = {
        callSnippet = "Replace"
      },
      type = {
        weakUnionCheck = true,
        weakNilCheck = true,
        castNumberToInteger = true,
      },
      format = {
        enable = false,
      },
      hint = {
        enable = true,
        arrayIndex = "Disable",
        await = true,
        paramName = "Disable",
        paramType = false,
        semicolon = "Disable",
        setType = true,
      },
      spell = { "the" },
      runtime = {
        version = "LuaJIT",
        special = {
          reload = "require",
        },
      },
      workspace = {
        library = {
          "${3rd}/luv/library",
          unpack(vim.api.nvim_get_runtime_file('', true)),
          vim.fn.expand("$VIMRUNTIME/lua"),
          vim.fn.stdpath("config") .. "/lua",
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
  install = true,
}
