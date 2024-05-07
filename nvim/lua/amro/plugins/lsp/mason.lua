return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "whoissethdaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      ensure_installed = {
        "mypy",
        "black",
        "debugpy",
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "pyright",
        "bashls",
        "dockerls",
        "terraformls",
        "tflint",
        "tsserver",
        "html",
        "cssls",
        "tailwindcss",
        "svelte",
        "autotools_ls",
        "lua_ls",
        "graphql",
        "emmet_ls",
        "prismals",
        "grammarly",
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "tflint",
        "eslint_d",
      },
    })
  end,
}
