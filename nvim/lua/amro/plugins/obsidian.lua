return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local obsidian = require("obsidian")

        obsidian.setup({
            workspaces = {
                {
                    name = "ALL",
                    path = "~/Documents/Obsidian/AmroMassalha/",
                },
            },
            notes_subdir = "inbox",
            new_notes_location = "notes_subdir",

            disable_frontmatter = true,
            templates = {
                subdir = "templates",
                date_format = "%Y-%m-%d",
                time_format = "%H:%M:%S",
            },
            mappings = {
                -- overrides the 'gf' mapping to work on markdown/wiki links within your vault
                ["gf"] = {
                    action = function()
                        return require("obsidian").util.gf_passthrough()
                    end,
                    opts = { noremap = false, expr = true, buffer = true },
                },
                -- toggle check-boxes
                -- ["<leader>ch"] = {
                --   action = function()
                --     return require("obsidian").util.toggle_checkbox()
                --   end,
                --   opts = { buffer = true },
                -- },
            },
            completion = {
                nvim_cmp = true,
                min_chars = 2,
            },
        })
    end,
}
