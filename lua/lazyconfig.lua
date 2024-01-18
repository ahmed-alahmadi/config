local lazy = require("lazy")
require("lazyfile").setup()

-- Properly load file based plugins without blocking the UI

local plugins = {
	{ "folke/lazy.nvim" },
	{
		"dustinblackman/oatmeal.nvim",
		cmd = { "Oatmeal" },
		keys = {
			{ "<leader>om", mode = "n", desc = "Start Oatmeal session" },
		},
		opts = {
			backend = "ollama",
			model = "openhermes2.5-mistral:latest",
		},
	},
	{
		"sourcegraph/sg.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim", --[[ "nvim-telescope/telescope.nvim ]]
		},
		event = { "LazyFile" },
		-- write a function to sort a list

		config = function()
			require("sg").setup({})
		end,
		-- If you have a recent version of lazy.nvim, you don't need to add this!
		build = "nvim -l build/init.lua",
	},
	{
		"ThePrimeagen/harpoon",
		dependencies = { "nvim-lua/plenary.nvim" },
		branch = "harpoon2",
		config = function()
			require("plugins.harpoon")
			-- vim.keymap.set("n", "<leader>ht", "<cmd>lua require('harpoon.term').gotoTerminal(1)<cr>")
		end,
		keys = {
			"<leader>hx",
			"<leader>ha",
			"<leader>hs",
			"<leader>hd",
			"<leader>hf",
			"<leader>hh",
			"<leader>ht",
			"<leader>hu",
			"<leader>o",
			"<leader>i",
		},
	},
	-- { "simrat39/rust-tools.nvim", lazy = true },
	{

		"mfussenegger/nvim-lint",
		event = { "LazyFile" },
		config = function()
			require("plugins.lint")
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		config = function()
			require("plugins.conform")
		end,
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "LazyFile",
		opts = {

			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
			},
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end


                -- stylua: ignore start
                map("n", "]h", gs.next_hunk, "Next Hunk")
                map("n", "[h", gs.prev_hunk, "Prev Hunk")
                map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
                map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
                map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
                map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
                map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
                map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
                map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
                map("n", "<leader>ghd", gs.diffthis, "Diff This")
                map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			end,
		},
	},
	{
		"NeogitOrg/neogit",
		cmd = "Neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"nvim-telescope/telescope.nvim", -- optional
			"sindrets/diffview.nvim", -- optional
			-- "ibhagwan/fzf-lua",              -- optional
		},
		config = function()
			require("neogit").setup({})
			vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>")
		end,
		keys = {
			"<leader>gg",
		},
	},
	-- { "nvim-tree/nvim-web-devicons", lazy = true },
	{ "windwp/nvim-ts-autotag", event = "LazyFile", opts = {} },
	{
		"folke/flash.nvim",
		-- event = "VeryLazy",
		vscode = true,
		opts = {},
		keys = {
			{
				"f",
				mode = { "n", "x", "o" },
			},
			{
				"F",
				mode = { "n", "x", "o" },
			},
			{
				"t",
				mode = { "n", "x", "o" },
			},
			{
				"T",
				mode = { "n", "x", "o" },
			},
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				"debugloop/telescope-undo.nvim",
				build = "make",
				enabled = vim.fn.executable("make") == 1,
			},
		},
		keys = {
			"<leader>ff",
			"<leader>fc",
			"<leader>sd",
			"<leader>sD",
			"<leader>gc",
			"<leader>gs",
			"<leader>fg",
			"<leader>fu",
		},
		config = function()
			require("plugins.telescope")
		end,
	},
	{ "folke/neodev.nvim", opts = {}, lazy = { "LazyFile" } },
	-- {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		event = { "LazyFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter-context", "JoosepAlviste/nvim-ts-context-commentstring" },
		config = function()
			require("ts_context_commentstring").setup({})
			vim.g.skip_ts_context_commentstring_module = true
			require("nvim-treesitter.configs").setup({

				highlight = { enable = true },
				autotag = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<CR>",
						scope_incremental = "<CR>",
						node_incremental = "<TAB>",
						node_decremental = "<S-TAB>",
					},
				},
				indent = { enable = true },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = "LazyFile",
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		},
		event = { "LazyFile" },
		config = function()
			require("plugins.lsp")
		end,
	},
	{
		"echasnovski/mini.completion",
		event = "LazyFile",
		config = function()
			require("mini.completion").setup({
				lsp_completion = {
					process_items = function(items, base)
						_G.args = { items = items, base = base }
						return MiniCompletion.default_process_items(items, base)
					end,
				},
			})

			local keys = {
				["cr"] = vim.api.nvim_replace_termcodes("<CR>", true, true, true),
				["ctrl-y"] = vim.api.nvim_replace_termcodes("<C-y>", true, true, true),
				["ctrl-y_cr"] = vim.api.nvim_replace_termcodes("<C-y><CR>", true, true, true),
			}

			_G.cr_action = function()
				if vim.fn.pumvisible() ~= 0 then
					-- If popup is visible, confirm selected item or add new line otherwise
					local item_selected = vim.fn.complete_info()["selected"] ~= -1
					return item_selected and keys["ctrl-y"] or keys["ctrl-y_cr"]
				else
					-- If popup is not visible, use plain `<CR>`. You might want to customize
					-- according to other plugins. For example, to use 'mini.pairs', replace
					-- next line with `return require('mini.pairs').cr()`
					return keys["cr"]
				end
			end

			vim.keymap.set("i", "<CR>", "v:lua._G.cr_action()", { expr = true })
		end,
	},
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},

	{
		"echasnovski/mini.pairs",
		event = "LazyFile",
		opts = {
			-- mappings = {
			-- 	["("] = { action = "open", pair = "()", neigh_pattern = "[^\\][^%)]" },
			-- 	["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\][^%]]" },
			-- 	["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\][^%}]" },
			-- },
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("RustPair", { clear = true }),
				pattern = { "rust" },
				command = "lua require('mini.pairs').map_buf(0, 'i', '|', {action = 'open', pair = '||'})",
			}),
		},
	},
	{ "echasnovski/mini.ai", event = "LazyFile", opts = {} },
	-- { "nvim-lualine/lualine.nvim", event = "VeryLazy", opts = {} },
	{
		"echasnovski/mini.surround",
		event = "LazyFile",
		opts = {
			mappings = {
				add = "gsa",
				delete = "gsd",
				replace = "gsr",
				find = "gsf",
				find_left = "gsF",
				highlight = "gsh",
				update_n_lines = "gsn",
			},
		},
		keys = {
			"gsa",
			"gsf",
			"gsh",
			"gsr",
			"gsd",
			"gsf",
		},
	},
	{
		"echasnovski/mini.comment",
		event = "LazyFile",
		keys = {
			"gcc",
			"gc",
		},
		opts = {},
	},
	{

		"rebelot/kanagawa.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd([[colorscheme kanagawa-dragon]])
		end,
	},
}
local opts = {
	ui = {
		size = { width = 0.9, height = 0.8 },
		border = "single",
	},
	dev = {
		path = "~/GeneralCoding/vim-plugins",
		patterns = { "SmiteshP" },
		fallback = true,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"netrwPlugin",
				"tohtml",
				"man",
				"tarPlugin",
				"zipPlugin",
				"gzip",
			},
		},
	},
}

lazy.setup(plugins, opt)
