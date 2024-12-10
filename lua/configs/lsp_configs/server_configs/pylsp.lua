-- pylsp.plugins.autopep8.enabled = false
-- pylsp.plugins.mccabe.enabled = false
-- pylsp.plugins.preload.enabled = false
-- pylsp.plugins.pycodestyle.enabled = false
-- pylsp.plugins.pyflakes.enabled = false
-- pylsp.plugins.yapf.enabled = false
return {
  settings = {
    -- https://github.com/python-lsp/python-lsp-server
    pylsp = {
      plugins = {
        autopep8 = {
          enabled = false,
        },
        jedi_completion = {
          fuzzy = true,
          include_class_objects = true,
          include_function_objects = true,
        },
        mccabe = {
          enabled = false,
        },
        preload = {
          enabled = false,
        },
        pycodestyle = {
          enabled = false,
          maxLineLength = 120,
        },
        -- pydocstyle = {
        --   enabled = true,
        -- },
        pyflakes = {
          enabled = false,
        },
        yapf = {
          enabled = true,
        },
      }
    }
  }
}
