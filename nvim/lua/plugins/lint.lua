return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")
        -- Configure nvim-lint
        lint.linters_by_ft = {
            tex = { 'proselint' },
            sh = { 'shellcheck' },
            markdown = { 'markdownlint', 'proselint' },
            gitcommit = { 'proselint' },
            rst = { 'rstcheck' },
            html = { 'tidy' },
            htmldjango = { 'tidy' },
            css = { 'stylelint' },
            python = { "pylint" },
        }

        -- Modify flake8 options
        local flake8 = require('lint.linters.flake8')
        flake8.args = {
            -- <- Add a new parameter here
            '--max-line-length=88',
            -- <--
            '--format=%(path)s:%(row)d:%(col)d:%(code)s:%(text)s',
            '--no-show-source',
            '-',
        }

        -- Make mypy use the active environment
        local mypy = require('lint.linters.mypy')
        local environment = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
        mypy.args = {
            '--show-column-numbers',
            '--show-error-end',
            '--hide-error-codes',
            '--hide-error-context',
            '--no-color-output',
            '--no-error-summary',
            '--no-pretty',
            -- use current active environment
            '--python-executable',
            environment .. '/bin/python',
            -- hide mypy errors on untyped modules (annoying in every import block)
            '--disable-error-code',
            'import-untyped'
        }

        -- Modify markdownlint options
        local markdownlint = require('lint.linters.markdownlint')
        markdownlint.args = { '--disable', 'MD012', 'MD033', 'MD034', 'MD041', '--' }

        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })

        vim.keymap.set("n", "<leader>l", function()
            lint.try_lint()
        end, { desc = "Trigger linting for current file" })
    end,
}
