return {
  filetypes = { "latex", "tex", "bib", "markdown" },
  settings = {
    ltex = {
      language = "en",
      checkFrequency = "edit",
      diagnosticSeverity = "information",
      setenceCacheSize = 2000,
      additionalRules = {
        enablePickyRules = true,
        motherTongue = "en",
      },
      trace = { server = "verbose" },
      dictionary = {},
      disabledRules = {},
      hiddenFalsePositives = {},
    },
  },
  install = false,
}
