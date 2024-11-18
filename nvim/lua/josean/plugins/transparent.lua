return {
  "xiyaowong/nvim-transparent",
  "bluz71/vim-moonfly-colors",
  "kdheepak/monochrome.nvim",
  "EdenEast/nightfox.nvim",
  "NLKNguyen/papercolor-theme",
  "folke/tokyonight.nvim",
  "rktjmp/lush.nvim",
  { "catppuccin/nvim", as = "catppuccin" },
  "nvim-telescope/telescope-file-browser.nvim",
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
  "smartpde/telescope-recent-files",
  "danielpieper/telescope-tmuxinator.nvim",
  "jvgrootveld/telescope-zoxide",
  { "ellisonleao/glow.nvim", opts = {} },
  "xiyaowong/telescope-emoji.nvim",
  "nvim-telescope/telescope-symbols.nvim",
  "cljoly/telescope-repo.nvim",
  "junegunn/fzf.vim",
  "nvim-tree/nvim-web-devicons",
  {
    "cuducos/yaml.nvim",
    ft = { "yaml" }, -- optional
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
    },
  },
  "kevinhwang91/nvim-bqf",
  {
    "junegunn/fzf",
    build = "./install --bin",
  },
  { "alexghergh/nvim-tmux-navigation", opts = { disable_when_zoomed = true } },
  "romainl/vim-cool",
  "yssl/QFEnter",
  "jesseleite/nvim-macroni",
  "nosduco/remote-sshfs.nvim",
  "towolf/vim-helm",
  "jbyuki/one-small-step-for-vimkind",
  {
    "michaelb/sniprun",
    build = "sh ./install.sh",
    opts = {
      display = { "Classic" },
    },
  },
}
