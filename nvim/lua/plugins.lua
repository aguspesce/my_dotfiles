
-- Plugins
-- -------

-- Autoinstall packer.nvim
local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer. Close and reopen Neovim."
    vim.cmd [[packadd packer.nvim]]
end

-- Install plugins
return require('packer').startup(function()
    -- Packer can manage itself
    use { 'wbthomason/packer.nvim' }

    -- File tree
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icon
        }
    }

    -- Buffer navifation
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- Nightfox theme
    use { 'EdenEast/nightfox.nvim' }

    -- Git signs
    use { 'tpope/vim-fugitive' }
    use { 'lewis6991/gitsigns.nvim' }

    -- Surrounding characters
    use 'tpope/vim-surround'

    -- Webdev
    use 'ap/vim-css-color'
    use {
      'mattn/emmet-vim',
       config = function()
           vim.g.user_emmet_leader_key = '<C-Z>'
       end
    }

    -- Comment.nvim
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

    -- Neoformat
    use { 'sbdchd/neoformat' }

    -- Autopair plugin
    use { 'windwp/nvim-autopairs' }

    -- Linter
    use { 'mfussenegger/nvim-lint' }

    -- Native LSP
    use { 'neovim/nvim-lspconfig' }

    -- cmp
    use { 'hrsh7th/nvim-cmp' } -- Autocompletion plugin
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'saadparwaiz1/cmp_luasnip' }
    use { 'L3MON4D3/LuaSnip' } -- Snippets pluing

    -- vim-python-pep8-indent
    use { 'Vimjas/vim-python-pep8-indent', }

    -- telescope
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.0',
       -- or                            , branch = '0.1.x',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    -- Preview markdown
    -- install without yarn or npm
    use({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
    })

    use({
      "iamcco/markdown-preview.nvim",
      run = "cd app && npm install",
      setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
      ft = { "markdown" },
    })

end)
