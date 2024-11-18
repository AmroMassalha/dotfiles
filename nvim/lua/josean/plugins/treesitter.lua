return {
  {
    "nvim-treesitter/playground",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    enabled = false,
  },
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    -- import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")

    -- configure treesitter
    treesitter.setup({ -- enable syntax highlighting
      ignore_install = {},
      sync_install = false,
      modules = {},
      highlight = { enable = true },
      auto_install = true,
      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
      },
      indent = {
        enable = false,
        -- disable yaml indenting because the grammar is too simplistic, other plugins do it better
        disable = { "yaml" },
        additional_vim_regex_highlighting = { "markdown" },
      },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = {
        enable = true,
      },
      -- ensure these language parsers are installed
      ensure_installed = {
        "json",
        "yaml",
        "markdown",
        "markdown_inline",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "query",
        "vimdoc",
        "terraform",
        "tmux",
        "helm",
        "bash",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}
