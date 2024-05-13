return {
  {
    "williamboman/mason.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      auto_install = true,
    },
    config = function()
      local mason_lsp = require("mason-lspconfig")

      mason_lsp.setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "terraformls",
          "tflint",
          "dockerls",
          "bashls",
          "autotools_ls",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim",             config = true },
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
      { "folke/neodev.nvim",                   opts = {} },
      { "b0o/schemastore.nvim" },
      { "j-hui/fidget.nvim",                   opts = {} },
    },
    config = function()
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.pyright.setup({
        root_dir = function(fname)
          return lspconfig.util.find_git_ancestor(fname)
              or lspconfig.util.root_pattern("setup.py", ".git", "venv")(fname)
              or lspconfig.util.path.dirname(fname)
        end,
        capabilities = capabilities,
        filetypes = { "python" },
      })
      lspconfig.terraformls.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          if client.resolved_capabilities.document_formatting then
            vim.api.nvim_buf_set_keymap(
              bufnr,
              "n",
              "<leader>gf",
              "<cmd>lua vim.lsp.buf.formatting()<CR>",
              { noremap = true, silent = true }
            )
          end
        end,
        flags = {
          debounce_text_changes = 150,
        },
        settings = {
          terraform = {
            terraform_ls = {
              logLevel = "warn",
            },
          },
        },
        on_attach = function(client)
          vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
        end,
      })
      lspconfig.autotools_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.bashls.setup({
        capabilities = capabilities,
        cmd = { "terraform-ls" },
        arg = { "server" },
        filetypes = { "terraform", "tf", "terraform-vars" },
        root_dir = function(fname)
          return lspconfig.util.find_git_ancestor(fname)
              or lspconfig.util.root_pattern(".git", "tf_venv")(fname)
              or lspconfig.util.path.dirname(fname)
        end,
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      })

      lspconfig.dockerls.setup({
        capabilities = capabilities,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
          map("gr", require("telescope.builtin").lsp_references, "Goto References")
          map("<leader>ca", vim.lsp.buf.code_action, "Show code action")

          map("<leader>d", vim.diagnostic.open_float, "Show line diagnostics")
          map("<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics")
          map("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
          map("]d", vim.diagnostic.goto_next, "Go to next diagnostic")

          map("<leader>v", "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>", "Goto Definition in Vertical Split")

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      require("lspconfig.ui.windows").default_options.border = "single"
      require("neodev").setup()
      -- used to enable autocompletion (assign to every lsp server config)
      local capabilities = cmp_nvim_lsp.default_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      -- Change the Diagnostic symbols in the sign column (gutter)
      -- (not in youtube nvim video)
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end
    end,
  },
}
