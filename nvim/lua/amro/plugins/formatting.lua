return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    -- General auto formatters setup
    local general_formatters_by_ft = {
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      lua = { "stylua" },
      terraform = { "terraform_fmt" },
      python = { "black", "isort" },
    }

    -- Python formatter setup for new files only
    vim.api.nvim_create_autocmd({ "BufNewFile" }, {
      pattern = "*.py",
      callback = function()
        conform.setup({
          formatters_by_ft = {
            python = { "black" },
          },
          format_on_save = {
            lsp_fallback = true,
            async = false,
            timeout_ms = 1000,
          },
        })
      end,
    })

    -- Setup for other file types
    conform.setup({
      formatters_by_ft = general_formatters_by_ft,
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })

    -- Manual format keymap
    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
