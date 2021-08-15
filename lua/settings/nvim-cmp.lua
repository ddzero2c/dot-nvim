require("cmp_nvim_lsp").setup({})

local cmp = require("cmp")
cmp.setup({
	-- You must set mapping.
	mapping = {
		["<C-p>"] = cmp.mapping.prev_item(),
		["<C-n>"] = cmp.mapping.next_item(),
		["<C-d>"] = cmp.mapping.scroll(-4),
		["<C-f>"] = cmp.mapping.scroll(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	},

	-- You should specify your *installed* sources.
	sources = {
		{ name = "lsp" },
	},
})
