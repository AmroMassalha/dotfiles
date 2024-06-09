return {
  {
    "nvim-neotest/nvim-nio",
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>db", "<cmd> DapToggleBreakpoint <CR>", silent = true, desc = "DEBUG: add/remove brackpoints" },
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      {
        "<leader>drd",
        function()
          require("dap-python").test_method()
        end,
        silent = true,
        desc = "DEBUG: run def code",
      },
      {
        "<leader>drc",
        function()
          require("dap-python").test_class()
        end,
        silent = true,
        desc = "DEBUG: run class code",
      },
      {
        "x",
        "<leader>drs",
        function()
          require("dap-python").debug_selection()
        end,
        silent = true,
        desc = "DEBUG: run selected code",
      },
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
    end,
  },
}
