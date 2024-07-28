return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        json = { "prettier" },
        yaml = { "~/.config/nvim/scripts/clean_yaml.sh" },
        markdown = { "prettier" },
        lua = { "stylua" },
        python = { "black --config ~/.config/black/pyproject.toml", "isort" },
        ["*"] = { "codespell" },
        ["_"] = { "trim_whitespace" },
        terraform = { "terraform_fmt" },
        tf = { "terraform_fmt" },
        hcl = { "terraform_fmt" },
      },
      notify_on_error = true,
      log_level = vim.log.levels.ERROR,
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
