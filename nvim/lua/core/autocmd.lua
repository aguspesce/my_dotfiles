function trim_trailing_whitespaces()
	if not vim.o.binary and vim.o.filetype ~= "diff" then
		local current_view = vim.fn.winsaveview()
		vim.cmd([[keeppatterns %s/\s\+$//e]])
		vim.fn.winrestview(current_view)
	end
end
--
-- Define autocommands
-- -------------------

-- Custom styles on augroup
vim.api.nvim_create_augroup("custom_style", { clear = true })
-- Change text last column for Python files
vim.api.nvim_create_autocmd("FileType", {
	group = "custom_style",
	pattern = { "python" },
	command = "setlocal colorcolumn=89",
})
-- Change text last column for Rust files
vim.api.nvim_create_autocmd("FileType", {
	group = "custom_style",
	pattern = { "rust" },
	command = "setlocal colorcolumn=100",
})
-- Set indentation to 2 characters for html, yml, markdown and lua files
vim.api.nvim_create_autocmd("FileType", {
	group = "custom_style",
	pattern = { "html", "htmldjango", "yml", "lua", "markdown" },
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

-- Remove trailing spaces on save
vim.api.nvim_create_augroup("trailing_spaces", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	group = "trailing_spaces",
	pattern = { "*" },
	callback = trim_trailing_whitespaces,
})

-- Enable spellcheck by default on some filetypes
vim.api.nvim_create_augroup("spelling", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = "spelling",
	pattern = { "html", "markdown", "python", "tex", "rst" },
	command = "setlocal spell | set spelllang=en",
})
