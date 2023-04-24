-- Keybindings
-- ===========

local keymap = vim.api.nvim_set_keymap


vim.g.mapleader = ' '  -- Remap space as leader key

-- Split keyboard shortcuts
local opts = {noremap = true}
keymap('n', '<C-j>', '<c-w>j',opts)  -- Up
keymap('n', '<C-h>', '<c-w>h',opts)  -- Left
keymap('n', '<C-k>', '<c-w>k',opts)  -- Down
keymap('n', '<C-l>', '<c-w>l',opts)  -- Right


-- Navigate between windows
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Move to the next and previous buffer
vim.keymap.set('n', '<leader>n', ':bnext<CR>')
vim.keymap.set('n', '<leader>p', ':bprevious<CR>')
vim.keymap.set('n', '<leader>d', ':bd<CR>')
vim.keymap.set('n', ']b', ':bnext<CR>')
vim.keymap.set('n', '[b', ':bprevious<CR>')

-- Remove search highlight
vim.keymap.set('n', '<leader><space>', ':noh<cr>')

-- Map "+y in order to copy to clipboard
-- In order to work, :echo has('clipboard') must return 1
-- Try installing xclip
vim.keymap.set('v', '<C-c>', '"+y')

