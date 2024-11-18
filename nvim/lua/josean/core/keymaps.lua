vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>tk", ":blast<enter>", { noremap = false })
keymap.set("n", "<leader>tj", ":bfirst<enter>", { noremap = false })
keymap.set("n", "<leader>tp", ":bprev<enter>", { noremap = false })
keymap.set("n", "<leader>tn", ":bnext<enter>", { noremap = false })
keymap.set("n", "<leader>tx", ":bdelete<enter>", { noremap = false })

keymap.set("n", "tw", ":Twilight<enter>", { noremap = false })

keymap.set("n", "QQ", ":q!<enter>", { noremap = false })
keymap.set("n", "WW", ":w!<enter>", { noremap = false })
keymap.set("n", "E", "$", { noremap = false })
keymap.set("n", "B", "^", { noremap = false })
keymap.set("n", "TT", ":TransparentToggle<CR>", { noremap = true })
