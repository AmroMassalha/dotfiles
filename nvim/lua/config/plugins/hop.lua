return {
  "phaazon/hop.nvim",
  branch = "v2", -- optional but strongly recommended
  lazy = true,
  config = function()
    -- you can configure Hop the way you like here; see :h hop-config
    require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
  end,

  vim.api.nvim_set_keymap("n", "t", "<cmd>HopPattern<CR>", { noremap = true }),
  vim.api.nvim_set_keymap("", "f", "<cmd>lua require'hop'.hint_char1()<cr>", {}),
}
