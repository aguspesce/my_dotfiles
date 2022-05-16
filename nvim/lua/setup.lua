-- Basic configuration
--

local o = vim.opt  -- General configuration
local wo = vim.wo  -- Window configuration
local bo = vim.bo  -- Buffer configuration

-- Show line numbers
o.number = true
wo.cursorline = true

o.emoji = true  -- Use emoji

o.clipboard = "unnamedplus" -- Vim uses the system clipboard

o.splitright = true  -- Open a new window on the right
o.hidden = true -- Do not save when switching buffers
o.lazyredraw = true

o.signcolumn = 'yes'

-- Autoindent
o.autoindent = true
o.expandtab = true
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4

-- Highlight all matches while searching
o.incsearch = true
o.hlsearch = true

wo.colorcolumn = '80'  -- Set window-scoped
o.autowrite = true

-- Enable mouse support
o.mouse = 'a'

o.breakindent = true --Enable break indent
o.undofile = true --Save undo history

-- Spell check configuration
o.spell = true
o.spelllang = {'en', 'es'}
