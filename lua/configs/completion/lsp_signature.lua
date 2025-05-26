return function()
  require("lsp_signature").setup({
    floating_window = false,
    handler_opts = { border = "single" },
  })
end
