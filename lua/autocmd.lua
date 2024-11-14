if vim.uv.os_uname().sysname == "Linux" then
  -- auto toggle fcitx5 state
  Fcitx_should_restore = false

  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
      local current_state = vim.fn.systemlist("fcitx5-remote")[1]
      if current_state == "2" then -- not en
        vim.fn.system("fcitx5-remote -c")
        Fcitx_should_restore = true
      end
    end
  })

  vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
      if Fcitx_should_restore then
        local current_state = vim.fn.systemlist("fcitx5-remote")[1]
        if current_state == "1" then -- en
          vim.fn.system("fcitx5-remote -o")
          Fcitx_should_restore = false
        end
      end
    end
  })
end

Format_on_save_bl_fts = {
  "md",
}
Format_on_save = require("utils.funcs").get_format_on_save()
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    if Format_on_save ~= true
        or require("utils.funcs").contains(
          Format_on_save_bl_fts, vim.bo.filetype) then
      return
    end
    local error_count = vim.diagnostic.count(0, {
      severity = vim.diagnostic.severity.ERROR
    })[1] or 0
    if error_count ~= 0 then
      return
    end
    require("utils.funcs").lsp_formatting(false)
  end,
})
