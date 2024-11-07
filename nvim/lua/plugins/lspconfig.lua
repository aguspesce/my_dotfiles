-- LSP Support
return {
	-- LSP Configuration
	"neovim/nvim-lspconfig",
	dependencies = {
		-- LSP Management
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		-- Auto-Install LSPs, linters, formatters, debuggers
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		-- Useful status updates for LSP
		"j-hui/fidget.nvim",
		-- Additional lua configuration, makes nvim stuff amazing!
		"folke/neodev.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- Install these LSPs automatically
		-- Pylsp plugins need to be installed with the :PylspInstall command
		-- provided by mason-lspconfig.
		-- Run this for example to install pylsp-mypy (runs mypy from the LSP
		-- itself):
		-- :PylspInstall pylsp-mypy
		-- Source: https://github.com/williamboman/mason-lspconfig.nvim/blob/4d0e5b49363cac187326998b96aa6a2884e0e89b/lua/mason-lspconfig/server_configurations/pylsp/README.md
		require("mason-lspconfig").setup({
			ensure_installed = {
				"bashls",
				"cssls",
				"html",
				"lua_ls",
				"jsonls",
				"lemminx",
				"marksman",
				"quick_lint_js",
				"yamlls",
				"pylsp",
				"ruff",
			},
			automatic_installation = true,
		})
		-- Install these linter's, formatters, debuggers automatically
		require("mason-tool-installer").setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"debugpy",
				"flake8",
				"isort", -- python formatter
				"black", -- python formatter
				"mypy",
				"pylint", -- python linter
				"proselint",
			},
			automatic_installation = true,
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "MasonToolsStartingInstall",
			callback = function()
				vim.schedule(function()
					print("mason-tool-installer is starting")
				end)
			end,
		})

		-- Import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- Used to enable autocompletion (assign to every lsp server config)
		local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
		-- local lsp_attach = function(client, bufnr)
		--   -- Create your keybindings here...
		-- end

		local keymap = vim.keymap -- For conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- Set keybindings
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			end,
		})

		-- Call setup on each LSP server
		require("mason-lspconfig").setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					on_attach = lsp_attach,
					capabilities = lsp_capabilities,
				})
			end,
		})

		-- Lua LSP settings
		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim" },
					},
					completion = { callSnippet = "Replace" },
				},
			},
		})

		-- Pylsp
		lspconfig.pylsp.setup({
			capabilities = lsp_capabilities,
			settings = {
				-- configure plugins in pylsp
				pylsp = {
					plugins = {
						pyflakes = { enabled = false },
						pylint = { enabled = false },
						flake8 = { enabled = false },
						pycodestyle = { enabled = false },
						jedi_completion = { fuzzy = true },
						pylsp_mypy = {
							-- needs pylsp-mypy
							-- (install with pip in the same environment as pylsp:
							-- https://github.com/python-lsp/python-lsp-server/discussions/546)
							enabled = true,
						},
					},
				},
			},
		})

		-- Ruff (python linter as lsp)
		lspconfig.ruff.setup({
			-- Configure settings: https://docs.astral.sh/ruff/editors/settings/#configuration
			init_options = {
				settings = {
					lint = {
						enable = true,
						extendSelect = { "F", "E", "ARG" },
					},
				},
			},
		})

		-- Globally configure all LSP floating preview popups (like hover, signature help, etc)
		local open_floating_preview = vim.lsp.util.open_floating_preview
		function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
			opts = opts or {}
			opts.border = opts.border or "rounded" -- Set border to rounded
			return open_floating_preview(contents, syntax, opts, ...)
		end
	end,
}
