-- Plugins setup
-- -------------

-- Nvim-tree setup
-- ---------------
-- empty setup using defaults: add your own options
require'nvim-tree'.setup { }
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<leader>r', ':NvimTreeRefresh<CR>')
vim.keymap.set('n', '<leader>n', ':NvimTreeFindFile<CR>')


-- Lualine setup
-- -------------
require('lualine').setup()


-- Nightfox setup
-- --------------
vim.cmd("colorscheme terafox")


-- Gitsigns setup
-- --------------
require('gitsigns').setup{
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, {expr=true})
        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, {expr=true})

        -- Actions
        map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
        map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
        map('n', '<leader>hS', gs.stage_buffer)
        map('n', '<leader>hu', gs.undo_stage_hunk)
        map('n', '<leader>hR', gs.reset_buffer)
        map('n', '<leader>hp', gs.preview_hunk)
        map('n', '<leader>hb', function() gs.blame_line{full=true} end)
        map('n', '<leader>tb', gs.toggle_current_line_blame)
        map('n', '<leader>hd', gs.diffthis)
        map('n', '<leader>hD', function() gs.diffthis('~') end)
        map('n', '<leader>td', gs.toggle_deleted)
        -- Text object
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
}


-- Comment setup
-- -------------
require('Comment').setup()


-- Buffer line setup
-- -----------------
vim.opt.termguicolors = true
require("bufferline").setup{}


-- LSP setup
-- ---------
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}


-- Bash language server
-- Need to install the server using: npm i -g bash-language-server
require('lspconfig')["bashls"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

-- C language server
require('lspconfig')["ccls"].setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
-- Pylsp
-- Need to install using: pip install python-lsp-server
require('lspconfig').pylsp.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        -- configure plugins in pylsp
        pylsp = {
            plugins = {
                pyflakes = {enabled = false},
                pylint = {enabled = false},
                flake8 = {enabled = false},
                pycodestyle = {enabled = false},
            },
        },
    },
}

-- Texlab
require('lspconfig')["texlab"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Neoformat setup
-- ---------------
vim.api.nvim_create_autocmd(
    "BufWritePre",
    {
        pattern = { "*.py", '*.html', '*.css', '*.md' },
        command = "Neoformat",
        desc = "Run Neoformat before writing",
    }
)
-- Don't stop when running the first formatter, run all
vim.g.neoformat_run_all_formatters = 1
-- Configure isort and black autoformatters
vim.g.neoformat_enabled_python = {'isort', 'black'}
vim.g.neoformat_python_isort = {args = {'--profile black'}}


-- Autopairs setup
-- ---------------
require('nvim-autopairs').setup{}


-- Linter setup
-- ------------
require('lint').linters_by_ft = {
    c= {'cppcheck'},
    python = {'flake8',},
    tex = {'chktex', --'lacheck'
    },
    sh = {'shellcheck'},
}

-- Cmp setup
-- ---------
local luasnip = require 'luasnip'
local cmp = require 'cmp'

-- Define function for completion with Tab
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  -- Disable autocompletion (must be manually triggered)
  completion = {
      autocomplete = false,
  },

  -- Define keybindings
  mapping = cmp.mapping.preset.insert({

    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),

  -- Configure sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
}

-- Telescope setup
-- ---------------
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-f>', builtin.git_files, {})
-- Need to install ripgrep using apt
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
