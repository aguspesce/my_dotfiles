-- Auto-completion / Snippets
vim.o.completeopt = 'menu,menuone,noselect'

return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'hrsh7th/cmp-buffer',           -- Source for text in buffer
        'hrsh7th/cmp-path',             -- Source for file system paths
        { 'L3MON4D3/LuaSnip', version = 'v2.*', build = 'make install_jsregexp' },
        'saadparwaiz1/cmp_luasnip',     -- for autocompletion
        'rafamadriz/friendly-snippets', -- Useful snippets
        'onsails/lspkind.nvim',         -- Vs-code like pictograms
        -- LSP completion capabilities
        'hrsh7th/cmp-nvim-lsp',

    },
    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        local lspkind = require('lspkind')

        -- Loads vscode style snippets from installed plugins (e.g. friendly-snippets)
        require('luasnip.loaders.from_vscode').lazy_load()
        luasnip.config.setup({})

        cmp.setup({
            completion = {
                completeopt = 'menu,menuone,preview,noselect',
            },
            snippet = {
                -- Configure how nvim-cmp interacts with snippet engine
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-k>'] = cmp.mapping.select_prev_item(), -- Previous suggestion
                ['<C-j>'] = cmp.mapping.select_next_item(), -- Next suggestion
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),    -- Scroll in the description windows
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),     -- Show completion suggestions
                ['<C-e>'] = cmp.mapping.abort(),            -- Close completion window
                ['<CR>'] = cmp.mapping.confirm({ select = false }),

                -- Tab through suggestions or when a snippet is active, tab to the next argument
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                -- Tab backwards through suggestions or when a snippet is active, tab to the next argument
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),
            -- Sources for autocompletion
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- Snippets
                { name = 'buffer' },  -- Text within current buffer
                { name = 'path' },    -- File system paths
            }),
            -- Configure lsp kind for vs-code like pictogram in completion menu
            formatting = {
                format = lspkind.cmp_format({
                    maxwidth = 50,
                    ellipsis_char = '...',
                }),
            },
            window = {
                -- Add borders to completions popups
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
        })
    end,
}
