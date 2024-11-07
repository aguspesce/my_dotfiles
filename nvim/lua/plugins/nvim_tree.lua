-- File Explorer / Tree
return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local nvimtree = require("nvim-tree")

		-- Recommended settings to disable default netrw file explorer
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		nvimtree.setup({
			view = { width = 35, relativenumber = true },
			-- Change folder arrow icons
			renderer = {
				indent_markers = { enable = true },
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "", -- Arrow when folder is closed
							arrow_open = "", -- Arrow when folder is open
						},
					},
				},
			},
			-- Disable window_picker for explorer to work well with
			-- Window splits
			actions = { open_file = { window_picker = { enable = false } } },
			filters = { custom = { ".DS_Store" } },
			git = { ignore = false },
		})

		-- Set key maps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
		keymap.set(
			"n",
			"<leader>ef",
			"<cmd>NvimTreeFindFileToggle<CR>",
			{ desc = "Toggle file explorer on current file" }
		)
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
		keymap.set("n", "<leader>r", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
	end,
}
