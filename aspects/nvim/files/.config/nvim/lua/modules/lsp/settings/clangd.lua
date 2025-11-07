return {
  cmd = {
    "clangd",
    "--background-index",
    "--fallback-style=Google",
    "--all-scopes-completion",
    "--clang-tidy",
    "--log=error",
    "--suggest-missing-includes",
    "--cross-file-rename",
    "--completion-style=detailed",
    "--pch-storage=memory",
    "--folding-ranges",
    "--enable-config",
    "--offset-encoding=utf-16",
    "--limit-references=1000",
    "--malloc-trim",
    "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
    "--header-insertion=never",
    "--query-driver=<list-of-white-listed-complers>"
  },
  settings = {
    clangd = {},
  },
  install = true,
}
