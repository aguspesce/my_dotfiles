-- Telescope setup
-- ---------------
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-f>', builtin.git_files, {})
-- Need to install ripgrep using apt
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fs', builtin.git_status, {})
vim.keymap.set('n', '<leader>fe', builtin.resume, {})
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, {})

-- Configure layout of telescope
require('telescope').setup({
  defaults = {
    layout_strategy = "vertical",
    layout_config = { height = 0.95 },
    },
})

