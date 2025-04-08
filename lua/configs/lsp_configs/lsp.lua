-- 1. mason
-- 2. mason-lspconfig
-- 3. lspconfig

return function()
  require("mason").setup({
    log_level = vim.log.levels.WARN,
    ui = {
      border = "single",
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      }
    }
  })

  require("mason-lspconfig").setup({
    ensure_installed = {
      "lua_ls",
      "bashls",
      "jsonls",
      "lemminx",
    }
  })

  -- Set icons for sidebar.
  local icons = require("utils.icons").get("diagnostics", true)
  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = icons.Error_alt,
        [vim.diagnostic.severity.WARN] = icons.Warning_alt,
        [vim.diagnostic.severity.INFO] = icons.Information_alt,
        [vim.diagnostic.severity.HINT] = icons.Hint_alt,
      },
      linehl = {
        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
        [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
        [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
        [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      },
    }
  })

  --- lspconfig --------------------------------------------
  local lspconfig = require("lspconfig")

  -- :h lsp-handler-configuration
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      -- :h vim.diagnostic.config()
      underline = {
        -- set to HINT for pyright to display gray out text
        severity = vim.diagnostic.severity.HINT,
      },
      virtual_text = {
        severity = vim.diagnostic.severity.ERROR,
      },
      signs = true,
      float = {
        style = "minimal",
        border = "single",
        focusable = false,
      },
      update_in_insert = false,
      severity_sort = true,
    }
  )

  -- :h vim.lsp.ClientConfig
  local opts = {
    -- capabilities = require("cmp_nvim_lsp").default_capabilities(),
    capabilities = require("blink.cmp").get_lsp_capabilities(),
  }

  require("mason-lspconfig").setup_handlers({
    function(server_name)
      local server_opts = opts

      local server_conf_file = vim.fn.stdpath("config") ..
          "/lua/configs/lsp_configs/server_configs/" ..
          server_name .. ".lua"
      if vim.fn.filereadable(server_conf_file) == 1
      then
        local require_ok
        require_ok, server_opts = pcall(require,
          "configs.lsp_configs.server_configs." .. server_name)
        if require_ok then
          server_opts = vim.tbl_deep_extend("force", server_opts, opts)
        else
          --vim.print(vim.inspect(server_opts))
          vim.notify("[mason-lspconfig] server settings of " ..
            server_name .. " load failed", vim.log.levels.WARN)
          server_opts = opts
        end
        -- else
        --   vim.notify("[mason-lspconfig] server " .. server_name ..
        --     " not configured", vim.log.levels.DEBUG)
      end

      -- :h lspconfig-setup
      lspconfig[server_name].setup(server_opts)
    end
  })

  pcall(vim.cmd.LspStart)
end
