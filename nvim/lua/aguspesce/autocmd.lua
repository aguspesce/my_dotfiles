-- Autocommands
-- ============

-- Show cursor line only in active window
-- --------------------------------------
vim.api.nvim_create_augroup("cursor_line", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter" }, {
    group = "cursor_line",
    pattern = "*",
    command = "set cursorline",
})
vim.api.nvim_create_autocmd({ "WinLeave" }, {
    group = "cursor_line",
    pattern = "*",
    command = "set nocursorline",
})


-- Remove all trailing whitespace on save
-- --------------------------------------
vim.api.nvim_create_augroup("trailing_spaces", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    group = "trailing_spaces",
    pattern = { "*" },
    command = [[:%s/\s\+$//e]],
})

-- Enable spellcheck by default on some filetypes
-- ----------------------------------------------
vim.api.nvim_create_augroup("spelling", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = "spelling",
    pattern = { "html", "markdown", "python", "tex", "rst" },
    command = "set spell | set spelllang=en",
})


-- Custom styles on augroup
-- ------------------------
vim.api.nvim_create_augroup("custom_style", { clear = true })
-- Change text last column for Python files
vim.api.nvim_create_autocmd("FileType", {
    group = "custom_style",
    pattern = { "python" },
    command = "setlocal colorcolumn=99",
})
-- Set indentation to 2 characters for html, yml and lua files
vim.api.nvim_create_autocmd("FileType", {
    group = "custom_style",
    pattern = { "html", "htmldjango", "yml", "lua" },
    command = "setlocal ts=2 sts=2 sw=2 expandtab",
})
-- Set indentation to 3 characters for rst files
vim.api.nvim_create_autocmd("FileType", {
    group = "custom_style",
    pattern = { "rst" },
    command = "setlocal ts=3 sts=3 sw=3 expandtab",
})
-- Configure Git commits
vim.api.nvim_create_autocmd("FileType", {
    group = "custom_style",
    pattern = { "gitcommit", "pullrequest" },
    command = "setlocal spell textwidth=72",
})
-- Autorun linter on read and write (requires nvim-lint)
-- vim.api.nvim_create_augroup("linter", { clear = true })
-- vim.api.nvim_create_autocmd({"BufNewFile", "BufEnter", "BufWritePost"}, {
--     group = "linter",
--     pattern = { "*" },
--     command = "lua require('lint').try_lint()",
-- })
-- -- Run neoformat after saving some chosen files (requires neoformat)
-- vim.api.nvim_create_augroup("neoformat", { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     group = "neoformat",
--     pattern = { "*.py", "*.html", "*.css", "*.less", "*.yml" },
--     command = "Neoformat",
-- })
--


