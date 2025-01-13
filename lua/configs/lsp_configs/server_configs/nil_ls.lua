return {
  on_attach = function(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil
  end,
  settings = {
    ["nil"] = {
      formatting = {
        command = { "alejandra" },
      },
    },
  },
}
