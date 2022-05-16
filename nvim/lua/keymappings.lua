-- Keybindings
-- -----------

local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = ' '  -- Remap space as leader key

keymap('n', '<c-s>', ':w<CR>',{}) -- Save with ctrl+s
keymap('i', '<c-s>', '<Esc>:w<CR>a',{}) -- Sace with ctrl+s
keymap('v', '<c-c>', '"+y', {}) -- Map "+y in order to copy to clipboard

-- Split keyboard shortcuts
local opts = {noremap = true}
keymap('n', '<c-j>', '<c-w>j',opts)  -- Up
keymap('n', '<c-h>', '<c-w>h',opts)  -- Left
keymap('n', '<c-k>', '<c-w>k',opts)  -- Down
keymap('n', '<c-l>', '<c-w>l',opts)  -- Right
