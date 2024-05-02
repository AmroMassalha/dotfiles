return {
    -- Neovim notifications and LSP progress messages
    {
        "j-hui/fidget.nvim",
        branch = "legacy",
        enabled = false,
        config = function()
            require("fidget").setup({
                window = { blend = 0 },
            })
        end,
    },

    -- Smooth scrolling neovim plugin written in lua
    {
        "karb94/neoscroll.nvim",
        config = function()
            require("neoscroll").setup({
                stop_eof = true,
                easing_function = "sine",
                hide_cursor = true,
                cursor_scrolls_alone = true,
            })
        end,
    },
}
