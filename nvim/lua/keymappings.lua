local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = ' '  -- Remap space as leader key

-- Save with Ctrl + S
keymap('n', '<c-s>', ':w<CR>',{})
keymap('i', '<c-s>', '<Esc>:w<CR>a',{})

-- Move around windows
local opts = {noremap = true}
keymap('n', '<c-j>', '<c-w>j',opts)  -- Up
keymap('n', '<c-h>', '<c-w>h',opts)  -- Left
keymap('n', '<c-k>', '<c-w>k',opts)  -- Down
keymap('n', '<c-l>', '<c-w>l',opts)  -- Right
