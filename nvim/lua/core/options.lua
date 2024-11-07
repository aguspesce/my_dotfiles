-- Basic configuration

local opt = vim.opt

vim.cmd('let g:netrw_liststyle = 3')

-- Map leader to space bar
vim.g.mapleader = ' '

-- Configure Python host
vim.g.python3_host_prog = '/usr/bin/python'

-- Line Numbers
opt.relativenumber = true
opt.number = true

-- Tabs & Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- Text wrap
opt.wrap = true
opt.breakindent = true
opt.textwidth = 79

-- Search Settings
opt.ignorecase = true
opt.smartcase = true

-- Highlight all matches while searching
opt.incsearch = true
opt.hlsearch = true

-- Add color column
opt.colorcolumn = '89'

-- Highlight cursor line
opt.cursorline = true

-- Appearance
opt.termguicolors = true
opt.background = 'dark'
opt.signcolumn = 'yes'
-- add border to diagnostic popups
vim.diagnostic.config { float = { border = 'rounded' } }
-- Use emoji
opt.emoji = true

-- Clipboard
opt.clipboard:append('unnamedplus')

-- Split Windows
opt.splitright = true
opt.splitbelow = true

-- Enable mouse support
opt.mouse = 'a'

--Save undo history
opt.undofile = true

-- Spell check configuration
opt.spell = true
opt.spelllang = { 'en', 'es' }

-- Set number of context lines when scrolling
opt.scrolloff = 10

-- Disable folding
opt.foldenable = false
