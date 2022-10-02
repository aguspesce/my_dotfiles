-- Basic configuration
--

local o = vim.opt  -- General configuration
local wo = vim.wo  -- Window configuration
local bo = vim.bo  -- Buffer configuration

-- Map leader to spacebar
vim.g.mapleader = " "

-- Configure Python host
vim.g.python3_host_prog = '/usr/bin/python'

-- Show line numbers
o.number = true

-- Highlight cursorline
wo.cursorline = true

o.emoji = true  -- Use emoji

o.clipboard = "unnamedplus" -- Vim uses the system clipboard

-- Split window
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

-- Text wrap
set.wrap = true
set.breakindent = true
set.textwidth = 79

-- Highlight all matches while searching
o.incsearch = true
o.hlsearch = true

-- Add colorcolumn
wo.colorcolumn = '80'

o.autowrite = true

-- Enable mouse support
o.mouse = 'a'

-- Add signcolumn
set.signcolumn = "yes"

o.breakindent = true --Enable break indent

o.undofile = true --Save undo history

-- Spell check configuration
o.spell = true
o.spelllang = {'en', 'es'}

-- Set number of context lines when scrolling
set.scrolloff = 10
