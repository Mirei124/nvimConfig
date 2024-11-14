return function()
  local null_ls = require("null-ls")
  local btns = null_ls.builtins
  local sources = {
    btns.formatting.prettier.with({
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "css",
        "scss",
        "less",
        "html",
        -- "json",
        -- "jsonc",
        "yaml",
        "markdown",
        "markdown.mdx",
        "graphql",
        "handlebars",
      },
    }),
    btns.formatting.shfmt.with({
      filetypes = { "sh", "zsh" },
      extra_args = { "-i", "2", "-ci" },
    }),
  }
  null_ls.setup({ border = "single", sources = sources })
  require("mason-null-ls").setup()
end
