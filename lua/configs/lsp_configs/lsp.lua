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

  -- :h vim.diagnostic.Opts
  local icons = require("utils.icons").get("diagnostics", true)
  vim.diagnostic.config({
    underline = { severity = vim.diagnostic.severity.ERROR },
    virtual_text = false,
    virtual_lines = false,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = icons.Error_alt,
        [vim.diagnostic.severity.WARN] = icons.Warning_alt,
        [vim.diagnostic.severity.INFO] = icons.Information_alt,
        [vim.diagnostic.severity.HINT] = icons.Hint_alt,
      },
    },
    update_in_insert = false,
    severity_sort = true,
  })

  --- lspconfig --------------------------------------------
  -- :h vim.lsp.ClientConfig
  local opts = {
    -- capabilities = require("cmp_nvim_lsp").default_capabilities(),
    capabilities = require("blink.cmp").get_lsp_capabilities(),
  }
  vim.lsp.config("*", opts)

  local function setup_lsp(server_name)
    local server_conf_file = vim.fn.stdpath("config") .. "/lua/server_configs/"
        .. server_name .. ".lua"
    if vim.fn.filereadable(server_conf_file) == 1
    then
      local require_ok, server_opts
      require_ok, server_opts = pcall(require, "server_configs." .. server_name)
      if require_ok then
        vim.lsp.config(server_name, server_opts)
      else
        --vim.print(vim.inspect(server_opts))
        vim.notify("[mason-lspconfig] server settings of " ..
          server_name .. " load failed", vim.log.levels.WARN)
      end
      -- else
      --   vim.notify("[mason-lspconfig] server " .. server_name ..
      --     " not configured", vim.log.levels.DEBUG)
    end
  end

  local lspconfig = require("mason-lspconfig")
  for _, v in ipairs(lspconfig.get_installed_servers()) do
    setup_lsp(v)
  end

  pcall(vim.cmd.LspStart)
end
