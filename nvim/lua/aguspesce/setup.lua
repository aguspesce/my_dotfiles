-- Basic configuration
-- ===================

local set = vim.opt  -- General configuration
local wo = vim.wo  -- Window configuration
local bo = vim.bo  -- Buffer configuration

-- Install nightfox
vim.cmd("colorscheme nightfox")

-- Map leader to spacebar
vim.g.mapleader = " "

-- Configure Python host
vim.g.python3_host_prog = '/usr/bin/python'

-- Show line numbers
set.number = true

-- Highlight cursorline
wo.cursorline = true

set.emoji = true  -- Use emoji

-- o.clipboard = "unnamedplus" -- Vim uses the system clipboard

-- Split window
set.splitright = true  -- Open a new window on the right
set.hidden = true -- Do not save when switching buffers
set.lazyredraw = true

-- Add signcolumn
set.signcolumn = 'yes'

-- Autoindent
set.autoindent = true
set.expandtab = true
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4

-- Text wrap
set.wrap = true
set.breakindent = true
set.textwidth = 79

-- Highlight all matches while searching
set.incsearch = true
set.hlsearch = true

-- Add colorcolumn
set.colorcolumn = '80'

set.autowrite = true

-- Enable mouse support
set.mouse = 'a'

-- Add signcolumn
set.signcolumn = "yes"

--Enable break indent
set.breakindent = true

--Save undo history
set.undofile = true

-- Spell check configuration
set.spell = true
set.spelllang = {'en', 'es'}

-- Set number of context lines when scrolling
set.scrolloff = 10
