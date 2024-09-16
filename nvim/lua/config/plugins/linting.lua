return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters.yamllint = {
      name = "yamllint",
      cmd = "yamllint",
      args = {
        "--config-file",
        "~/dotfiles/lint/.yamllint",
        "-",
      },
      stdin = true,
      parser = require("lint.parser").from_errorformat("%f:%l:%c: %t: %m", {
        source = "yamllint",
        severity = {
          ["error"] = vim.diagnostic.severity.ERROR,
          ["warning"] = vim.diagnostic.severity.WARN,
          ["info"] = vim.diagnostic.severity.INFO,
        },
      }),
    }

    lint.linters_by_ft = {
      python = { "pylint" },
      terraform = { "tflint" },
      yaml = { "yamllint" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
