local actions = require("telescope.actions")
require("telescope").setup({

	defaults = {
		-- layout_strategy = 'vertical',
		layout_config = { height = 0.95 },
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
	},
})
require("telescope").load_extension("fzf")
require("telescope").load_extension("undo")
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files <cr>")
vim.keymap.set("n", "<leader><leader>ff", "<cmd>Telescope find_files hidden=true<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers <cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fu", "<cmd>Telescope undo<cr>")
vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>")
vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>")
vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>")
vim.keymap.set("n", "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>")
vim.keymap.set("n", "<leader>sD", "<cmd>Telescope diagnostics<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>")
