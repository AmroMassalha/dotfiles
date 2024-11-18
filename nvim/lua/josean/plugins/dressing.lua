return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  config = function()
    require("dressing").setup({
      select = {
        enabled = true,
        get_config = function(opts)
          if opts.kind == "codeaction" then
            return { enabled = false }
          end
        end,
        backend = { "fzf_lua" },
        fzf_lua = {
          -- Customize options for fzf_lua if needed
          -- winopts = {
          --   height = 0.5,
          --   width = 0.5,
          -- },
        },
      },
    })
  end,
}
