return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local helpers = require("null-ls.helpers")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.terraform_fmt,

        null_ls.builtins.diagnostics.terraform_validate,
        null_ls.builtins.diagnostics.tfsec,
        null_ls.builtins.diagnostics.pylint,
        null_ls.builtins.diagnostics.markdownlint,

        null_ls.builtins.completion.spell,
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    local markdownlint = {
      method = null_ls.methods.DIAGNOSTICS,
      filetypes = { "markdown" },
      generator = null_ls.generator({
        command = "markdownlint",
        args = { "--stdin" },
        to_stdin = true,
        from_stderr = true,
        format = "line",
        check_exit_code = function(code, stderr)
          local success = code <= 1

          if not success then
            print(stderr)
          end

          return success
        end,
        on_output = helpers.diagnostics.from_patterns({
          {
            pattern = [[:(%d+):(%d+) [%w-/]+ (.*)]],
            groups = { "row", "col", "message" },
          },
          {
            pattern = [[:(%d+) [%w-/]+ (.*)]],
            groups = { "row", "message" },
          },
        }),
      }),
    }

    null_ls.register(markdownlint)
  end,
}
