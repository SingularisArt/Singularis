return {
  on_attach = function(client, _)
    client.server_capabilities.offsetEncoding = { "utf-16" }
  end,
}
