Format_blacklist_clients = {
  "bashls",
  "marksman",
  "pylsp",
  "pyright",
}

-- @param tbl table
-- @param value string
local function contains(tbl, value)
  for _, v in ipairs(tbl) do
    if v == value then
      return true
    end
  end
  return false
end

-- @param use_async boolean
local function lsp_formatting(use_async)
  if use_async == nil then
    use_async = true
  end
  vim.lsp.buf.format({
    filter = function(client)
      -- local cs = vim.lsp.get_active_clients({ bufnr = vim.fn.bufnr() })
      if contains(Format_blacklist_clients, client.name) then
        return false
      end

      -- vim.notify("Format using " .. client.name, vim.log.levels.INFO,
      --   { title = "LSP" })
      require("fidget").notify("Format using " .. client.name,
        vim.log.levels.INFO, {
          skip_history = true,
        })
      return true
    end,
    async = use_async,
  })
end

local format_on_save_file = vim.fn.stdpath("state") .. "/disable_fos"

local function get_format_on_save()
  return vim.fn.empty(vim.fn.glob(format_on_save_file)) ~= 0
end

local function toggle_format_on_save()
  if get_format_on_save() then
    vim.fn.writefile({}, format_on_save_file, "b")
    Format_on_save = false
  else
    vim.fn.delete(format_on_save_file)
    Format_on_save = true
  end
end

local function command_panel()
  require("telescope.builtin").keymaps({
    lhs_filter = function(lhs)
      return not string.find(lhs, "Þ")
    end,
    layout_config = {
      width = 0.8,
      height = 0.8,
      prompt_position = "top",
    },
  })
end

return {
  contains = contains,
  lsp_formatting = lsp_formatting,
  get_format_on_save = get_format_on_save,
  toggle_format_on_save = toggle_format_on_save,
  command_panel = command_panel,
}
