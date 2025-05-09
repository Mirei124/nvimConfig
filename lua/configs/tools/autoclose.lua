return function()
  require("autoclose").setup({
    keys = {
      ["("] = { escape = false, close = true, pair = "()" },
      ["["] = { escape = false, close = true, pair = "[]" },
      ["{"] = { escape = false, close = true, pair = "{}" },

      ["<"] = { escape = true, close = true, pair = "<>", enabled_filetypes = { "rust" } },
      [">"] = { escape = true, close = false, pair = "<>" },
      [")"] = { escape = true, close = false, pair = "()" },
      ["]"] = { escape = true, close = false, pair = "[]" },
      ["}"] = { escape = true, close = false, pair = "{}" },

      ['"'] = { escape = true, close = true, pair = '""' },
      ["`"] = { escape = true, close = true, pair = "``" },
      ["'"] = { escape = true, close = true, pair = "''", disabled_filetypes = { "rust" } },
    },
    options = {
      disabled_filetypes = { "bigfile" },
      disable_when_touch = false,
      touch_regex = "[%w(%[{]",
      pair_spaces = true,
      auto_indent = true,
      disable_command_mode = true,
    },
  })
end
