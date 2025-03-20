local night_theme = "night-owl" -- koehler
local day_theme = "shine"
My_theme = night_theme
My_lualine_theme = "nord"

return {
  toggle_theme = function(target_theme)
    if target_theme == nil then
      if My_theme == night_theme
      then
        target_theme = day_theme
      else
        target_theme = night_theme
      end
    end
    vim.cmd("colorscheme " .. target_theme)
    require("lualine").setup({
      -- options = { theme = target_theme }
      options = { theme = My_lualine_theme }
    })
    My_theme = target_theme
  end
}
