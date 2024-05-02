return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "williamboman/mason.nvim", config = true },
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim", opts = {} },
        { "b0o/schemastore.nvim" },
        { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
        -- import lspconfig plugin
        local lspconfig = require("lspconfig")

        -- import mason_lspconfig plugin
        local mason_lspconfig = require("mason-lspconfig")

        -- import cmp-nvim-lsp plugin
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local keymap = vim.keymap -- for conciseness

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
                map("gr", require("telescope.builtin").lsp_references, "Goto References")
                map("gi", require("telescope.builtin").lsp_implementations, "Goto Implementation")
                map("go", require("telescope.builtin").lsp_type_definitions, "Type Definition")
                map("<leader>p", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
                map("<leader>P", require("telescope.builtin").lsp_workspace_symbols, "Workspace Symbols")
                map("<leader>Ps", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")

                map("K", vim.lsp.buf.hover, "Hover Documentation")
                map("gs", vim.lsp.buf.signature_help, "Signature Documentation")
                map("gD", vim.lsp.buf.declaration, "Goto Declaration")

                map("<leader>d", vim.diagnostic.open_float, "Show line diagnostics")
                map("<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics")
                map("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
                map("]d", vim.diagnostic.goto_next, "Go to next diagnostic")

                map("<leader>v", "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>", "Goto Definition in Vertical Split")

                -- Thank you teej
                -- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L502
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

        mason_lspconfig.setup_handlers({
            -- default handler for installed servers
            function(server_name)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                })
            end,
            ["svelte"] = function()
                -- configure svelte server
                lspconfig["svelte"].setup({
                    capabilities = capabilities,
                    on_attach = function(client, bufnr)
                        vim.api.nvim_create_autocmd("BufWritePost", {
                            pattern = { "*.js", "*.ts" },
                            callback = function(ctx)
                                -- Here use ctx.match instead of ctx.file
                                client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
                            end,
                        })
                    end,
                })
            end,
            ["graphql"] = function()
                -- configure graphql language server
                lspconfig["graphql"].setup({
                    capabilities = capabilities,
                    filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
                })
            end,
            ["emmet_ls"] = function()
                -- configure emmet language server
                lspconfig["emmet_ls"].setup({
                    capabilities = capabilities,
                    filetypes = {
                        "html",
                        "typescriptreact",
                        "javascriptreact",
                        "css",
                        "sass",
                        "scss",
                        "less",
                        "svelte",
                    },
                })
            end,
            ["lua_ls"] = function()
                -- configure lua server (with special settings)
                lspconfig["lua_ls"].setup({
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            -- make the language server recognize "vim" global
                            diagnostics = {
                                globals = { "vim" },
                            },
                            completion = {
                                callSnippet = "Replace",
                            },
                        },
                    },
                })
            end,
            ["terraformls"] = function()
                lspconfig["terraformls"].setup({
                    cmd = { "terraform-ls" },
                    arg = { "server" },
                    filetypes = { "terraform", "tf", "terraform-vars" },
                })
            end,
            ["grammarly"] = function()
                lspconfig["grammarly"].setup({
                    root_dir = function(fname)
                        return lspconfig.util.find_git_ancestor(fname)
                            or lspconfig.util.root_pattern("keep")(fname)
                            or lspconfig.util.path.dirname(fname)
                    end,
                })
            end,
            ["pyright"] = function()
                lspconfig["pyright"].setup({
                    root_dir = function(fname)
                        return lspconfig.util.find_git_ancestor(fname)
                            or lspconfig.util.root_pattern("setup.py", ".git", "venv")(fname)
                            or lspconfig.util.path.dirname(fname)
                    end,
                    settings = {
                        python = {
                            analysis = {
                                typeCheckingMode = "basic", -- Adjust as needed: "off", "basic", "strict"
                                autoSearchPaths = true,
                                useLibraryCodeForTypes = true,
                                diagnosticMode = "workspace",
                            },
                        },
                    },
                    capabilities = capabilities,
                })
            end,
        })
    end,
}
