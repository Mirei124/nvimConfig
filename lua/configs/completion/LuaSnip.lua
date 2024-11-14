return function()
  require("luasnip").setup({
    ft_func = require("luasnip.extras.filetype_functions").from_pos_or_filetype
    -- load_ft_func = require("luasnip.extras.filetype_functions").extend_load_ft({
    --   lua = { "luadoc" },
    -- }),
  })
  require("luasnip.loaders.from_lua").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_snipmate").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load({
    paths = { "./my_snippets" },
  })
end
