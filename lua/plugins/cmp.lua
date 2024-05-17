local cmp = require("cmp")
-- cmp.event:on("menu_opened", function()
-- 	vim.b.copilot_suggestion_hidden = true
-- end)

-- cmp.event:on("menu_closed", function()
-- 	vim.b.copilot_suggestion_hidden = false
-- end)
-- require("codeium").setup({})
local luasnip = require("luasnip")
local defaults = require("cmp.config.default")()
local cmp_kinds = {
	Array = " ",
	Boolean = "󰨙 ",
	Class = " ",
	Codeium = "󰘦 ",
	Color = " ",
	Control = " ",
	Collapsed = " ",
	Constant = "󰏿 ",
	Constructor = " ",
	Copilot = " ",
	Enum = " ",
	EnumMember = " ",
	Event = " ",
	Field = " ",
	File = " ",
	Folder = " ",
	Function = "󰊕 ",
	Interface = " ",
	Key = " ",
	Keyword = " ",
	Method = "󰊕 ",
	Module = " ",
	Namespace = "󰦮 ",
	Null = " ",
	Number = "󰎠 ",
	Object = " ",
	Operator = " ",
	Package = " ",
	Property = " ",
	Reference = " ",
	Snippet = " ",
	String = " ",
	Struct = "󰆼 ",
	TabNine = "󰏚 ",
	Text = " ",
	TypeParameter = " ",
	Unit = " ",
	Value = " ",
	Variable = "󰀫 ",
}

vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
local opts = {
	performance = {
		max_view_entries = 7,
	},
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	experimental = {
		ghost_text = {

			hl_group = "CmpGhostText",
		},
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sorting = defaults.sorting,
	window = {
		completion = cmp.config.window.bordered({ border = "rounded" }),
		documentation = cmp.config.window.bordered({ border = "rounded" }),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<S-CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<C-CR>"] = function(fallback)
			cmp.abort()
			fallback()
		end,
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp", max_item_count = 6, keyword_length = 2, priority = 100 },
		-- { name = "copilot", priority = 85,max_item_count=2 },
		{ name = "luasnip", max_item_count = 3, priority = 70 },
		{ name = "path" },
	}, {
		{ name = "buffer", keyword_length = 4, priority = 60, max_item_count = 3 },
	}),
	formatting = {
		format = function(_, item)
			if cmp_kinds[item.kind] then
				item.kind = cmp_kinds[item.kind] .. item.kind
			end
			return item
		end,
	},
}

for _, source in ipairs(opts.sources) do
	source.group_index = source.group_index or 1
end

cmp.setup(opts)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "cmp_docs",
	callback = function()
		vim.treesitter.start(0, "markdown")
	end,
})
