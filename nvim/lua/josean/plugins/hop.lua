return {
  "phaazon/hop.nvim",
  branch = "v2",
  config = function()
    local hop = require("hop")
    hop.setup({ keys = "etovxqpdygfblzhckisuran" })

    vim.keymap.set("n", "f", function()
      hop.hint_char1({ direction = require("hop.hint").HintDirection.AFTER_CURSOR })
    end, { silent = true })
    vim.keymap.set("n", "F", function()
      hop.hint_char1({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR })
    end, { silent = true })
    vim.keymap.set("n", "t", function()
      hop.hint_char1({ direction = require("hop.hint").HintDirection.AFTER_CURSOR, current_line_only = true })
    end, { silent = true })
    vim.keymap.set("n", "T", function()
      hop.hint_char1({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR, current_line_only = true })
    end, { silent = true })
  end,
}
