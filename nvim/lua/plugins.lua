-- Plugins
-- -------


return require('packer').startup(function()
    use { 'wbthomason/packer.nvim' } -- Package manager itself

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icon
        }
    } -- File tree

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    } -- Neovim statusline

    use { 'EdenEast/nightfox.nvim'} -- Nightfox theme

    use { 'lewis6991/gitsigns.nvim' } -- Git signs

    use {
        'numToStr/Comment.nvim',
        config = function()
        require('Comment').setup()
        end
    } -- Commenting plugin

    use {
        'akinsho/bufferline.nvim', tag = "v2.*",
        requires = 'kyazdani42/nvim-web-devicons'
    } -- Buffer line

    use { 'sbdchd/neoformat' } -- Neoformat

    use { 'windwp/nvim-autopairs' } -- Autopair plugin

    use { 'mfussenegger/nvim-lint' } -- Linter

    use { 'neovim/nvim-lspconfig' } -- Collection of configurations for built-in LSP client

    use { 'hrsh7th/nvim-cmp' } -- Autocompletion plugin
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-path' }
    use { 'saadparwaiz1/cmp_luasnip' }
    use { 'L3MON4D3/LuaSnip' } -- Snippets pluing
end)
