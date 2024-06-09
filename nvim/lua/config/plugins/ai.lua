return {
  {
    "David-Kunz/gen.nvim",
    config = function()
      local gen = require("gen")
      gen.setup({
        model = "codellama",
      })
      gen.prompts["devops me!"] = {
        prompt = "You are a senior devops engineer, acting as an assistant. You offer help with cloud technologies like: Terraform, AWS, kubernetes, python. You answer with code examples when possible. $input:\n$text",
        replace = true,
      }
    end,
  },
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
  },
}
