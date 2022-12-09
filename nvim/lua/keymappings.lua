-- Keybindings
-- -----------

local keymap = vim.api.nvim_set_keymap


vim.g.mapleader = ' '  -- Remap space as leader key

keymap('n', '<C-s>', ':w<CR>',{}) -- Save with ctrl+s
keymap('i', '<C-s>', '<Esc>:w<CR>a',{}) -- Sace with ctrl+s
keymap('v', '<C-c>', '"+y', {}) -- Map "+y in order to copy to clipboard

-- Split keyboard shortcuts
local opts = {noremap = true}
keymap('n', '<C-j>', '<c-w>j',opts)  -- Up
keymap('n', '<C-h>', '<c-w>h',opts)  -- Left
keymap('n', '<C-k>', '<c-w>k',opts)  -- Down
keymap('n', '<C-l>', '<c-w>l',opts)  -- Right
