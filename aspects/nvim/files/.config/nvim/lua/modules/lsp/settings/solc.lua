return {
  -- cmd = { "solc", "--lsp", "--import-path", "node_modules" },
  cmd = { "solc", "--lsp", "--include-path", "../node_modules" },
  install = true,
}
