return {
  "nvimtools/none-ls.nvim",

  dependencies = { "mason.nvim" },

  opts = function(_, opts)
    opts.root_dir = opts.root_dir
        or require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")
  end,
  config = function()
    local augroup = vim.api.nvim_create_augroup("NoneLsFormatting", {})
    local on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
          end,
        })
      end
    end

    local null_ls = require("null-ls")
    local helpers = require("null-ls.helpers")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier.with({
          disabled_filetypes = { "yaml.ansible" },
        }),
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.terraform_fmt,

        null_ls.builtins.diagnostics.terraform_validate,
        null_ls.builtins.diagnostics.tfsec,
        null_ls.builtins.diagnostics.pylint,
        null_ls.builtins.diagnostics.markdownlint,
        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.diagnostics.ansible_lint,

        null_ls.builtins.completion.spell,
      },
      on_attach = on_attach,
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
    on_attach = on_attach
  end,
}
