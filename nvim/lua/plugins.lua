-- Plugins
--

return require('packer').startup(function()
  -- Packer can manage itself
  use { 'wbthomason/packer.nvim' }

  -- Add file tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    }
  }

  -- Lualine
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- Nightfox
  use { 'EdenEast/nightfox.nvim'}

  -- Gitsigns
  use {
    'lewis6991/gitsigns.nvim',
    -- tag = 'release' -- To use the latest release
  }

  -- Comment
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  -- Buffer line
  use {
    'akinsho/bufferline.nvim', tag = "v2.*",
    requires = 'kyazdani42/nvim-web-devicons'
  }

  -- Collection of configurations for the built-in LSP client
  use { 'neovim/nvim-lspconfig' }

  -- Neoformat
  use { 'sbdchd/neoformat' }

  -- Autopairs
  use({ "windwp/nvim-autopairs" })

  -- Linter
   use {'mfussenegger/nvim-lint'}
end)
