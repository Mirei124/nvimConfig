return function()
  require("lsp_signature").setup({
    floating_window = true,
    handler_opts = { border = "single" },
  })
end
