return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "jonarrien/telescope-cmdline.nvim",
    "folke/todo-comments.nvim",
    "danielpieper/telescope-tmuxinator.nvim",
    "jvgrootveld/telescope-zoxide",
    { "ellisonleao/glow.nvim", opts = {} },
    "xiyaowong/telescope-emoji.nvim",
    "nvim-telescope/telescope-symbols.nvim",
    "cljoly/telescope-repo.nvim",
    {
      "nvim-telescope/telescope.nvim",
      dependencies = {
        { "nvim-lua/popup.nvim" },
        { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" },
        { "nvim-telescope/telescope-github.nvim" },
      },
    },
    {
      "nvim-telescope/telescope-file-browser.nvim",
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    "smartpde/telescope-recent-files",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")
    local z_utils = require("telescope._extensions.zoxide.utils")
    local lga_actions = require("telescope-live-grep-args.actions")
    local transform_mod = require("telescope.actions.mt").transform_mod

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.sources.telescope")

    -- or create your custom action
    local custom_actions = transform_mod({
      open_trouble_qflist = function(prompt_bufnr)
        trouble.toggle("quickfix")
      end,
    })

    telescope.setup({
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
        },
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ["<C-t>"] = trouble_telescope.open,
          },
        },
      },
      extensions = {
        live_grep_args = {
          auto_quoting = true, -- enable/disable auto-quoting
          -- define mappings, e.g.
          mappings = { -- extend mappings
            i = {
              ["<C-k>"] = lga_actions.quote_prompt(),
              ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
              -- freeze the current list and start a fuzzy search in the frozen list
              ["<C-space>"] = actions.to_fuzzy_refine,
            },
          },
          -- ... also accepts theme settings, for example:
          -- theme = "dropdown", -- use dropdown theme
          -- theme = { }, -- use own theme spec
          -- layout_config = { mirror=true }, -- mirror preview pane
        },
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
        file_browser = {
          hidden = true,
        },
        emoji = {
          action = function(emoji)
            vim.fn.setreg("*", emoji.value)
            print([[Press p or "*p to paste this emoji]] .. emoji.value)
            -- insert emoji when picked
            vim.api.nvim_put({ emoji.value }, "c", false, true)
          end,
        },
        zoxide = {
          prompt_title = "[ Zoxide List ]",
          -- Zoxide list command with score
          list_command = "zoxide query -ls",
          mappings = {
            default = {
              keepinsert = true,
              action = function(selection)
                builtin.find_files({
                  cwd = selection.path,
                  find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
                })
                -- builtin.find_files({ cwd = selection.path })
              end,
            },
            ["<C-s>"] = { action = z_utils.create_basic_command("split") },
            ["<C-v>"] = { action = z_utils.create_basic_command("vsplit") },
            ["<C-e>"] = { action = z_utils.create_basic_command("edit") },
            ["<C-b>"] = {
              keepinsert = true,
              action = function(selection)
                builtin.file_browser({ cwd = selection.path })
              end,
            },
            ["<C-f>"] = {
              keepinsert = true,
              action = function(selection)
                builtin.find_files({
                  cwd = selection.path,
                  find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
                })
              end,
            },
          },
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("file_browser")
    telescope.load_extension("repo")
    telescope.load_extension("fzf")
    telescope.load_extension("emoji")
    telescope.load_extension("zoxide")
    telescope.load_extension("tmuxinator")
    telescope.load_extension("cmdline")
    telescope.load_extension("live_grep_args")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set(
      "n",
      "<leader>ff",
      [[<cmd>Telescope find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git'}, search_dirs = {require('user_functions.shell_integration').get_tmux_working_directory()}, path_display = {"truncate"} })<cr>]],
      { desc = "Fuzzy find files in cwd" }
    )
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    keymap.set("n", "<leader>?", [[<cmd>lua require('telescope.builtin').help_tags()<CR>]])

    local function search_git(visual)
      -- Retrieve the git root path
      local handle = io.popen("git rev-parse --show-toplevel")
      if not handle then
        print("Error: Unable to open git handle")
        return
      end

      local git_root_path = handle:read("*a"):gsub("%s+", "")
      handle:close()

      if not git_root_path or git_root_path == "" then
        print("Error: Unable to retrieve git root path")
        return
      end

      local opts = {
        prompt_title = visual and ("Visual-Grep in " .. git_root_path) or ("Live-Grep in " .. git_root_path),
        shorten_path = false,
        cwd = git_root_path,
        file_ignore_patterns = { ".git", ".png", "tags" },
        initial_mode = "insert",
        selection_strategy = "reset",
        theme = require("telescope.themes").get_dropdown({}),
      }

      if visual then
        -- Capture the selected text in visual mode
        vim.cmd('normal! "vy')
        local visual_selection = vim.fn.getreg("v")
        opts.search = visual_selection
        require("telescope.builtin").grep_string(opts)
      else
        require("telescope.builtin").live_grep(opts)
      end
    end

    vim.keymap.set("n", "<leader>fs", function()
      search_git(false)
    end, { remap = true, silent = false, desc = "Live grep in the git root folder" })

    vim.keymap.set("v", "<leader>fs", function()
      search_git(true)
    end, { remap = true, silent = false, desc = "Grep in the git root folder" })
    -- Retrieve the current tmux session path
    -- This will not change when we navigate to a different pane
    local function search_tmux(visual)
      local handle = io.popen("tmux display-message -p '#{session_path}'")
      if not handle then
        print("Error: Unable to open tmux handle")
        return
      end

      local tmux_session_path = handle:read("*a"):gsub("%s+", "")
      handle:close()

      if not tmux_session_path or tmux_session_path == "" then
        print("Error: Unable to retrieve tmux session path")
        return
      end

      local opts = {
        prompt_title = visual and ("Visual-Grep in " .. tmux_session_path) or ("Live-Grep in " .. tmux_session_path),
        shorten_path = false,
        cwd = tmux_session_path,
        file_ignore_patterns = { ".git", ".png", "tags" },
        initial_mode = "insert",
        selection_strategy = "reset",
        theme = require("telescope.themes").get_dropdown({}),
      }

      if visual then
        require("telescope.builtin").grep_string(opts)
      else
        require("telescope.builtin").live_grep(opts)
      end
    end

    local default_opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<leader>lt", function()
      search_tmux(false)
    end, { remap = true, silent = false, desc = "Live grep in the current tmux session folder" })

    vim.keymap.set("v", "<leader>lt", function()
      search_tmux(true)
    end, { remap = true, silent = false, desc = "Grep string in the current tmux session folder" })
    vim.api.nvim_set_keymap(
      "v",
      "<leader>ls",
      'y<ESC>:Telescope live_grep default_text=<c-r>0<CR> search_dirs={"$PWD"}',
      default_opts
    )
    vim.keymap.set("n", "<leader>/", function()
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
        relative = "editor",
      }))
    end, { desc = "Find in current buffer" })
  end,
}
