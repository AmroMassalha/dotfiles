return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    "jackysee/telescope-hg.nvim",
    "folke/noice.nvim",
    {
      "exosyphon/telescope-color-picker.nvim",
      config = function()
        vim.keymap.set("n", "<leader>uC", "<cmd>Telescope colors<CR>", { desc = "Telescope Color Picker" })
      end,
    },
    {
      "ANGkeith/telescope-terraform-doc.nvim",
      config = function()
        require("telescope").load_extension("terraform_doc")
      end,
    },
    {
      "cappyzawa/telescope-terraform.nvim",
      config = function()
        require("telescope").load_extension("terraform")
      end,
    },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("hg")
    telescope.load_extension("noice")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

    -- hg keymaps
    keymap.set("n", "<leader>hgf", "<cmd>Telescope hg files<cr>", { desc = "Show files managed by hg" })
    keymap.set("n", "<leader>hgs", "<cmd>Telescope hg status<cr>", { desc = "Status; show changed files" })
    keymap.set("n", "<leader>hgb", "<cmd>Telescope hg branches<cr>", { desc = "Branches; list repo named branches" })
  end,
}
