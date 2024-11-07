local keymap = vim.keymap

-- Remap space as leader key
vim.g.mapleader = " "

-- Navigate between windows
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")

-- Split window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Tab management
keymap.set("n", " <leader>to", " <cmd>tabnew<CR>", { desc = " Open new tab" })
keymap.set("n", " <leader>tx", " <cmd>tabclose<CR>", { desc = " Close current tab" })
keymap.set("n", " <leader>tn", " <cmd>tabn<CR>", { desc = " Go to next tab" })
keymap.set("n", " <leader>tp", " <cmd>tabp<CR>", { desc = " Go to previous tab" })
keymap.set("n", " <leader>tf", " <cmd>tabnew %<CR>", { desc = " Open current buffer in new tab" })

-- Move to the next and previous buffer
keymap.set("n", "<leader>n", ":bnext<CR>")
keymap.set("n", "<leader>p", ":bprevious<CR>")
keymap.set("n", "<leader>d", ":bd<CR>")
keymap.set("n", "]b", ":bnext<CR>")
keymap.set("n", "[b", ":bprevious<CR>")

-- Remove search highlight
keymap.set("n", "<leader><space>", ":noh<cr>", { desc = " Clear search highlights" })

-- Vim-maximizer
keymap.set("n", " <leader>sm", " :MaximizerToggle<CR>") -- toggle maximize tab

-- Map "+y in order to copy to clipboard
-- In order to work, :echo has('clipboard') must return 1
-- Try installing xclip
vim.keymap.set("v", "<C-c>", '"+y')

-- Search selected text
keymap.set("v", " //", [[y/\V<C-R>=escape(@' ,'/\')<CR><CR>]])
