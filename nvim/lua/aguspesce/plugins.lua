-- Install plugins using packer.nvim
-- =================================

-- Autoinstall packer.nvim
-- -----------------------
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system {
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path
    }
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- Packer can manage itself
  use { 'wbthomason/packer.nvim' }

  -- Mason (package manager for LSPs)
  use {
    'williamboman/mason.nvim',
    run = ':MasonUpdate', -- :MasonUpdate updates registry contents
    config = function() require('mason').setup() end,
  }

  -- Nightfox theme
  use { 'EdenEast/nightfox.nvim' }

  -- File tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons', },
    config = function() require('aguspesce.plugins.nvim-tree') end,
  }

  -- Lualine
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require('aguspesce.plugins.lualine') end,
  }

  -- Comment.nvim
  use {
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end,
  }

  -- Buffer line
  use {
    'akinsho/bufferline.nvim', tag = "v3.*",
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require('aguspesce.plugins.bufferline') end,
  }

  -- Webdev
  use { 'ap/vim-css-color' }
  use {
    'mattn/emmet-vim',
    config = function() vim.g.user_emmet_leader_key = '<C-Z>' end
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    -- or                            , branch = '0.1.x',
    requires = {{'nvim-lua/plenary.nvim'}},
      config = function() require('aguspesce.plugins.telescope') end,
  }

  -- Preview markdown
  -- install without yarn or npm
  use({
    'iamcco/markdown-preview.nvim',
    run = 'cd app && npm install',
    setup = function() vim.g.mkdp_filetypes = { 'markdown' } end,
    ft = { 'markdown' },
  })

  -- Git
  use {
    'tpope/vim-fugitive',
    config = function() require('aguspesce.plugins.fugitive') end,
  }
  use {
    'lewis6991/gitsigns.nvim',
    config = function() require('aguspesce.plugins.gitsigns') end,
  }

  -- LaTeX
  use {
    'lervag/vimtex',
    config = function() require('aguspesce.plugins.vimtex') end,
  }

  -- Autoformat
  use {
    'sbdchd/neoformat',
    config = function() require('aguspesce.plugins.neoformat') end,
}

  -- Autopair plugin
  use {
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup {} end,
  }

  -- Linter
  use {
    'mfussenegger/nvim-lint',
    config = function() require('aguspesce.plugins.nvim-lint') end,
  }

  -- vim-python-pep8-indent
  use { 'Vimjas/vim-python-pep8-indent', }

  -- undotree
  use { 'mbbill/undotree' }

  -- neogen (autogenerate docstrings)
  use {
    'danymat/neogen',
    config = function() require('aguspesce.plugins.neogen') end,
    requires = 'nvim-treesitter/nvim-treesitter',
    -- Uncomment next line if you want to follow only stable versions
    tag = "*"
  }

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    config = function() require('aguspesce.plugins.lspconfig') end,
  }

  -- cmp
  use {
    'hrsh7th/nvim-cmp',
    config = function() require('aguspesce.plugins.cmp') end,
    requires = {
      -- Autocompletion plugin
      'hrsh7th/cmp-nvim-lsp',  -- LSP source for nvim-cmp
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',      -- complete paths with nvim-cmp
      -- Snippets
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-vsnip',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip'
    }
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
