-- elflord koehler night-owl nord shine
local night_theme = "nightfox"
local day_theme = "dayfox"
My_theme = night_theme
My_lualine_theme = My_theme

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
      options = { theme = target_theme }
      -- options = { theme = My_lualine_theme }
    })
    My_theme = target_theme
  end
}
