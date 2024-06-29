vim.cmd("let g:netrw_liststyle = 3")

vim.opt.encoding = "utf-8" -- set encoding
vim.opt.nu = true -- enable line numbers
vim.opt.relativenumber = true -- relative line numbers

vim.opt.conceallevel = 2 -- so that `` is visible in markdown files

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- convert tabs to spaces
-- vim.wo.wrap = false -- do not wrap lines
vim.opt.autoindent = true -- auto indentation
vim.opt.list = true -- show tab characters and trailing whitespace
vim.opt.formatoptions:remove("t") -- no auto-intent of line breaks, keep line wrap enabled
vim.opt.listchars = "tab:»\\ ,extends:›,precedes:‹,nbsp:·,trail:·" -- show tab characters and trailing whitespace

vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- unless capital letter in search

vim.opt.swapfile = false -- do not use a swap file for the buffer
vim.opt.backup = false -- do not keep a backup file
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- set directory where undo files are stored
vim.opt.undofile = true -- save undo history to a file

vim.opt.hlsearch = false -- do not highlight all matches on previous search pattern
vim.opt.incsearch = true -- incrementally highlight searches as you type

vim.opt.termguicolors = true -- enable true color support

vim.opt.scrolloff = 8 -- minimum number of lines to keep above and below the cursor
vim.opt.sidescrolloff = 8 --minimum number of columns to keep above and below the cursor
vim.opt.signcolumn = "yes" -- always show the sign column, to avoid text shifting when signs are displayed
vim.opt.isfname:append("@-@") -- include '@' in the set of characters considered part of a file name

vim.opt.updatetime = 50 -- Time in milliseconds to wait before triggering the plugin events after a change

vim.opt.colorcolumn = "120" -- highlight column 120

-- clipboard
vim.opt.clipboard:append("unnamedplus")

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd('normal! g`"')
    end
  end,
}) -- return to last edit position when opening files

local HighlightYank = vim.api.nvim_create_augroup("HighlightYank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
  group = HighlightYank,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
}) -- highlight yanked text using the 'IncSearch' highlight group for 40ms

local CleanOnSave = vim.api.nvim_create_augroup("CleanOnSave", {})
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = CleanOnSave,
  pattern = "*",
  command = [[%s/\s\+$//e]],
}) -- remove trailing whitespace from all lines before saving a file)

vim.api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*/templates/*.yaml", "*/templates/*.tpl", "*.gotmpl", "helmfile*.yaml" },
  callback = function()
    vim.opt_local.filetype = "helm"
  end,
})
