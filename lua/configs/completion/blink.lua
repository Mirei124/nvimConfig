return function()
  require("blink.cmp").setup({
    enabled = function()
      return vim.bo.buftype ~= "prompt"
          and vim.bo.filetype ~= "bigfile"
          and vim.b.completion ~= false
    end,
    keymap = {
      preset = "default",
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "cancel", "fallback" },
      ["<CR>"] = { "accept", "fallback" },

      ["<Tab>"] = {
        function(cmp)
          if cmp.is_visible() then
            return cmp.select_next()
          elseif cmp.snippet_active() then
            return cmp.snippet_forward()
          end
        end,
        "fallback",
      },
      ["<S-Tab>"] = {
        function(cmp)
          if cmp.is_visible() then
            return cmp.select_prev()
          elseif cmp.snippet_active() then
            return cmp.snippet_backward()
          end
        end,
        "fallback",
      },

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    completion = {
      list          = {
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },
      documentation = {
        auto_show = true,
        window = { border = "single" }
      },
      menu          = {
        auto_show = function(ctx)
          return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
        end,
        border = "single",
        draw = {
          columns = {
            { "label",      "label_description", gap = 1 },
            { "kind_icon",  "kind",              gap = 1 },
            { "source_name" },
          },
          align_to = "label",
          components = {
            kind_icon = {
              text = function(ctx)
                return require("lspkind").symbolic(ctx.kind, {
                  mode = "symbol",
                  symbol_map = { Copilot = "", Supermaven = "" },
                })
              end,
            },
            source_name = {
              text = function(ctx)
                return "[" .. string.sub(ctx.source_name, 0, 3) .. "]"
              end,
            },
          },
        },
      },
      ghost_text    = { enabled = true },
      trigger       = { show_in_snippet = false },
    },
    signature = { window = { border = "single" } },
    snippets = { preset = "luasnip" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      providers = {
        nvim_lua = {
          name = "nvim_lua",
          module = "blink.compat.source",
          score_offset = 3,
        },
        spell = {
          name = "spell",
          module = "blink.compat.source",
          score_offset = 3,
        },
        latex_symbols = {
          name = "latex_symbols",
          module = "blink.compat.source",
          score_offset = 3,
        },
        treesitter = {
          name = "treesitter",
          module = "blink.compat.source",
          score_offset = 3,
        },
      }
    },
  })
end
