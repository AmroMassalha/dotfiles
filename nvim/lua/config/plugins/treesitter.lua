return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  opts = function(_)
    vim.treesitter.language.register("hcl", "terraform")
    vim.treesitter.language.register("hcl", "terraform-vars")
  end,
  config = function()
    -- import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

    parser_config.gotmpl = {
      install_info = {
        url = "https://github.com/ngalaiko/tree-sitter-go-template",
        files = { "src/parser.c" },
      },
      filetype = "gotmpl",
      used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml" },
    }

    -- configure treesitter
    treesitter.setup({ -- enable syntax highlighting
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      sync_install = false,
      auto_install = true,
      -- enable indentation
      indent = { enable = true },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = {
        enable = true,
      },
      -- ensure these language parsers are installed
      ensure_installed = {
        "bash",
        "lua",
        "yaml",
        "dockerfile",
        "go",
        "hcl",
        "json",
        "make",
        "python",
        "gotmpl",
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
