local sysname = vim.loop.os_uname().sysname
local api = vim.api

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- Autocmd Groups
local indentSettings = api.nvim_create_augroup("IndentSettings", { clear = true })
local yamlSettings = api.nvim_create_augroup("YamlSettings", { clear = true })
local fileTypeSettings = api.nvim_create_augroup("FileTypeSettings", { clear = true })
local helpersGroup = api.nvim_create_augroup("Helpers", { clear = true })
local plantumlGroup = api.nvim_create_augroup("PlantUML", { clear = true })
local lastCursorGroup = api.nvim_create_augroup("LastCursorPosition", { clear = true })
local formattingGroup = api.nvim_create_augroup("AutoFormatting", { clear = true })
local highlightingGroup = api.nvim_create_augroup("Highlighting", { clear = true })

-- Functions
local function stylua_format()
  local file_path = vim.fn.expand("%:p")
  vim.fn.system({ "stylua", "--search-parent-directories", file_path })
  vim.cmd("e")
end

local function shfmt_format()
  local file_path = vim.fn.expand("%:p")
  vim.fn.system({ "shfmt", "-l", "-w", file_path })
  vim.cmd("e") -- Reload the file after formatting
end

api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = formattingGroup,
  pattern = "*",
  command = "if mode() != 'c' | checktime | endif",
})

api.nvim_create_autocmd("BufWritePost", {
  group = formattingGroup,
  pattern = { "*.sh", "*.bash" },
  callback = function()
    shfmt_format()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.autoindent = true
  end,
  group = indentSettings,
})

-- YAML Settings
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.yaml",
  callback = function()
    vim.cmd("silent! Neoformat")
  end,
  group = yamlSettings,
})

-- File Type Settings
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = ".envrc",
  callback = function()
    vim.bo.filetype = "sh"
  end,
  group = fileTypeSettings,
})

--TODO: fix the group indintation autocommand
