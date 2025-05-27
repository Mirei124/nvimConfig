-- https://docs.astral.sh/ruff/editors/settings/
return {
  init_options = {
    settings = {
      lineLength = 120,
      lint = {
        -- https://docs.astral.sh/ruff/rules/
        extendSelect = { "D2", "D3", "D4" },
      },
    }
  }
}
